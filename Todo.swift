// MARK: - Model

import Foundation
import Combine
import UIKit
import SwiftUI

// Todo model
struct Todo: Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - Services

// TodoService protocol
protocol TodoServiceProtocol {
    func fetchTodos() -> AnyPublisher<[Todo], Error>
    func addTodo(_ todo: Todo) -> AnyPublisher<Todo, Error>
    func toggleTodoCompletion(id: UUID) -> AnyPublisher<Todo, Error>
    func deleteTodo(id: UUID) -> AnyPublisher<Void, Error>
}

// Error types
enum TodoServiceError: Error {
    case fetchFailed
    case saveFailed
    case updateFailed
    case deleteFailed
}

// TodoService implementation (in-memory for simplicity)
class TodoService: TodoServiceProtocol {
    private var todos: [Todo] = [
        Todo(title: "Kupić mleko"),
        Todo(title: "Oddać książkę do biblioteki"),
        Todo(title: "Zadzwonić do mamy")
    ]
    
    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        return Just(todos)
            .setFailureType(to: Error.self)
            .delay(for: .milliseconds(300), scheduler: DispatchQueue.main) // Simulate network delay
            .eraseToAnyPublisher()
    }
    
    func addTodo(_ todo: Todo) -> AnyPublisher<Todo, Error> {
        return Future<Todo, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(TodoServiceError.saveFailed))
                return
            }
            
            self.todos.append(todo)
            promise(.success(todo))
        }
        .eraseToAnyPublisher()
    }
    
    func toggleTodoCompletion(id: UUID) -> AnyPublisher<Todo, Error> {
        return Future<Todo, Error> { [weak self] promise in
            guard let self = self,
                  let index = self.todos.firstIndex(where: { $0.id == id }) else {
                promise(.failure(TodoServiceError.updateFailed))
                return
            }
            
            self.todos[index].isCompleted.toggle()
            promise(.success(self.todos[index]))
        }
        .eraseToAnyPublisher()
    }
    
    func deleteTodo(id: UUID) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(TodoServiceError.deleteFailed))
                return
            }
            
            self.todos.removeAll { $0.id == id }
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Coordinators

// Base coordinator protocol
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    func addChild(_ coordinator: Coordinator)
    func removeChild(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

// App coordinator
class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let container: Resolver
    
    init(navigationController: UINavigationController, container: Resolver) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let todoListCoordinator = TodoListCoordinator(navigationController: navigationController, container: container)
        addChild(todoListCoordinator)
        todoListCoordinator.start()
    }
}

// TodoList coordinator
protocol TodoListCoordinatorProtocol: AnyObject {
    func showAddTodo()
    func refreshList()
}

class TodoListCoordinator: Coordinator, TodoListCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let container: Resolver
    
    init(navigationController: UINavigationController, container: Resolver) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel = container.resolve(TodoListViewModel.self)!
        viewModel.coordinator = self
        
        let todoListVC = TodoListViewController(viewModel: viewModel)
        navigationController.setViewControllers([todoListVC], animated: false)
    }
    
    func showAddTodo() {
        let addTodoCoordinator = AddTodoCoordinator(navigationController: navigationController, container: container, parentCoordinator: self)
        addChild(addTodoCoordinator)
        addTodoCoordinator.start()
    }
    
    func refreshList() {
        if let todoListVC = navigationController.viewControllers.first as? TodoListViewController {
            todoListVC.viewModel.loadTodos()
        }
    }
    
    func childDidFinish(_ child: Coordinator) {
        removeChild(child)
    }
}

// AddTodo coordinator
protocol AddTodoCoordinatorProtocol: AnyObject {
    func dismiss(todoAdded: Bool)
}

class AddTodoCoordinator: Coordinator, AddTodoCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let container: Resolver
    private weak var parentCoordinator: TodoListCoordinatorProtocol?
    
    init(navigationController: UINavigationController, container: Resolver, parentCoordinator: TodoListCoordinatorProtocol) {
        self.navigationController = navigationController
        self.container = container
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewModel = container.resolve(AddTodoViewModel.self)!
        viewModel.coordinator = self
        
        let addTodoVC = AddTodoViewController(viewModel: viewModel)
        
        // Używamy prezentacji modalnej dla ekranu dodawania
        if let presentationController = addTodoVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        navigationController.present(addTodoVC, animated: true)
    }
    
    func dismiss(todoAdded: Bool) {
        navigationController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            if todoAdded {
                self.parentCoordinator?.refreshList()
            }
            
            if let parent = self.parentCoordinator as? TodoListCoordinator {
                parent.childDidFinish(self)
            }
        }
    }
}

// MARK: - View Models

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let todoService: TodoServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: TodoListCoordinatorProtocol?
    
    init(todoService: TodoServiceProtocol) {
        self.todoService = todoService
        loadTodos()
    }
    
    func loadTodos() {
        isLoading = true
        
        todoService.fetchTodos()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure = completion {
                    self?.errorMessage = "Nie udało się załadować zadań."
                }
            } receiveValue: { [weak self] todos in
                self?.todos = todos
            }
            .store(in: &cancellables)
    }
    
    func toggleTodoCompletion(id: UUID) {
        todoService.toggleTodoCompletion(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure = completion {
                    self?.errorMessage = "Nie udało się zaktualizować zadania."
                    self?.loadTodos() // Reload on error
                }
            } receiveValue: { [weak self] updatedTodo in
                guard let self = self,
                      let index = self.todos.firstIndex(where: { $0.id == updatedTodo.id }) else { return }
                
                self.todos[index] = updatedTodo
            }
            .store(in: &cancellables)
    }
    
    func deleteTodo(id: UUID) {
        todoService.deleteTodo(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure = completion {
                    self?.errorMessage = "Nie udało się usunąć zadania."
                    self?.loadTodos() // Reload on error
                }
            } receiveValue: { [weak self] _ in
                self?.todos.removeAll { $0.id == id }
            }
            .store(in: &cancellables)
    }
    
    func addTodoTapped() {
        coordinator?.showAddTodo()
    }
}

class AddTodoViewModel: ObservableObject {
    @Published var todoTitle: String = ""
    @Published var errorMessage: String?
    @Published var isSaving: Bool = false
    
    private let todoService: TodoServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: AddTodoCoordinatorProtocol?
    
    init(todoService: TodoServiceProtocol) {
        self.todoService = todoService
    }
    
    func addTodo() {
        guard !todoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Tytuł zadania nie może być pusty."
            return
        }
        
        isSaving = true
        let newTodo = Todo(title: todoTitle)
        
        todoService.addTodo(newTodo)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completionStatus in
                self?.isSaving = false
                
                if case .failure = completionStatus {
                    self?.errorMessage = "Nie udało się dodać zadania."
                } else {
                    self?.coordinator?.dismiss(todoAdded: true)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func cancel() {
        coordinator?.dismiss(todoAdded: false)
    }
}

// MARK: - SwiftUI Views as Components

// Todo Row View Component
struct TodoRowView: View {
    let todo: Todo
    let toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Button(action: toggleCompletion) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
                    .font(.system(size: 20))
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Text(todo.title)
                .strikethrough(todo.isCompleted, color: .gray)
                .foregroundColor(todo.isCompleted ? .gray : .primary)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// MARK: - ViewControllers

// TodoList View Controller
class TodoListViewController: UIViewController {
    let viewModel: TodoListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var todoListHostingController: UIHostingController<AnyView> = {
        let todoList = UIHostingController(rootView: AnyView(TodoListContainerView(viewModel: viewModel)))
        return todoList
    }()
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Moje zadania"
        view.backgroundColor = .systemBackground
        
        // Add "+" button to navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoTapped))
        navigationItem.rightBarButtonItem = addButton
        
        // Add refresh button to navigation bar
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.leftBarButtonItem = refreshButton
        
        // Add SwiftUI todoList as child
        addChild(todoListHostingController)
        view.addSubview(todoListHostingController.view)
        todoListHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoListHostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoListHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoListHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoListHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        todoListHostingController.didMove(toParent: self)
    }
    
    private func setupBindings() {
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showAlert(title: "Błąd", message: message)
            }
            .store(in: &cancellables)
    }
    
    @objc private func addTodoTapped() {
        viewModel.addTodoTapped()
    }
    
    @objc private func refreshTapped() {
        viewModel.loadTodos()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// SwiftUI container view for TodoList
private struct TodoListContainerView: View {
    @ObservedObject var viewModel: TodoListViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRowView(todo: todo) {
                        viewModel.toggleTodoCompletion(id: todo.id)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteTodo(id: viewModel.todos[index].id)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
    }
}

// AddTodo View Controller
class AddTodoViewController: UIViewController {
    let viewModel: AddTodoViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var addTodoHostingController: UIHostingController<AnyView> = {
        let addTodoView = UIHostingController(rootView: AnyView(AddTodoContainerView(viewModel: viewModel)))
        return addTodoView
    }()
    
    init(viewModel: AddTodoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Dodaj zadanie"
        view.backgroundColor = .systemBackground
        
        // Add cancel and save buttons to navigation bar
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let navigationItem = UINavigationItem(title: "Dodaj zadanie")
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationBar.items = [navigationItem]
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Add SwiftUI addTodoView as child
        addChild(addTodoHostingController)
        view.addSubview(addTodoHostingController.view)
        addTodoHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTodoHostingController.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            addTodoHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addTodoHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addTodoHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        addTodoHostingController.didMove(toParent: self)
    }
    
    private func setupBindings() {
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showAlert(title: "Błąd", message: message)
            }
            .store(in: &cancellables)
    }
    
    @objc private func cancelTapped() {
        viewModel.cancel()
    }
    
    @objc private func saveTapped() {
        viewModel.addTodo()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// SwiftUI container view for AddTodo
private struct AddTodoContainerView: View {
    @ObservedObject var viewModel: AddTodoViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Nowe zadanie")) {
                TextField("Tytuł zadania", text: $viewModel.todoTitle)
            }
            
            if viewModel.isSaving {
                Section {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Dependency Injection (Swinject)

import Swinject

extension Container {
    static let shared = Container()
    
    static func setupDependencies() {
        // Register services
        shared.register(TodoServiceProtocol.self) { _ in TodoService() }.inObjectScope(.container)
        
        // Register view models
        shared.register(TodoListViewModel.self) { resolver in
            TodoListViewModel(todoService: resolver.resolve(TodoServiceProtocol.self)!)
        }
        
        shared.register(AddTodoViewModel.self) { resolver in
            AddTodoViewModel(todoService: resolver.resolve(TodoServiceProtocol.self)!)
        }
    }
}

 //MARK: - App Entry Point

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Container.setupDependencies()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController, container: Container.shared)
        appCoordinator?.start()
        
        window.makeKeyAndVisible()
        
        return true
    }
}
