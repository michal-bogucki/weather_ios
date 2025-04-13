import UIKit
import Combine
import SwiftUI
import Swinject

// MARK: - Models

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isDone: Bool = false
}

// MARK: - Presenter Outputs

enum ProfilePresenterOutput {
    case editAboutMe
    case editAddress
}

enum AboutMeEditorPresenterOutput {
    case finished(aboutMe: String?)
}

enum AddressPresenterOutput {
    case editCity
    case editStreet
    case backToProfile
}

enum CityEditorPresenterOutput {
    case finished(city: String?)
}

enum StreetEditorPresenterOutput {
    case finished(street: String?)
}

enum TasksPresenterOutput {
    case addTask
    case taskSelected(Task)
}

enum AddTaskPresenterOutput {
    case finished(task: Task?)
}

// MARK: - Home Coordinator

class HomeCoordinator {
    private let resolver: Resolver
    private let window: UIWindow
    private var cancellables = [AnyCancellable]()
    
    init(resolver: Resolver, window: UIWindow) {
        self.resolver = resolver
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let profile = makeProfile()
        let tasks = makeTasks()
        
        tabBarController.setViewControllers([profile, tasks], animated: false)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension HomeCoordinator {
    func makeProfile() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let profileCoordinator = resolver.resolve(
            ProfileCoordinator.self,
            argument: navigationController
        )!
        
        profileCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeTasks() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let tasksCoordinator = resolver.resolve(
            TasksCoordinator.self,
            argument: navigationController
        )!
        
        tasksCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
}

// MARK: - Profile Coordinator

class ProfileCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.tabBarItem.title = "Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        
        let profilePresenter = resolver.resolve(ProfilePresenter.self)!
        let profile = ProfileScreen(presenter: profilePresenter)
        let profileVC = CustomHostingController(rootView: profile)
        profileVC.title = "Profile"
        
        navigationController.viewControllers = [profileVC]
        
        profilePresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .editAboutMe:
                    self.showAboutMeEditor()
                case .editAddress:
                    self.showAddressScreen()
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showAboutMeEditor() {
        let aboutMeCoordinator = resolver.resolve(
            AboutMeEditorCoordinator.self,
            argument: navigationController
        )!
        
        aboutMeCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    private func showAddressScreen() {
        let addressCoordinator = resolver.resolve(
            AddressCoordinator.self,
            argument: navigationController
        )!
        
        addressCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
    }
}

// MARK: - Tasks Coordinator

class TasksCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.tabBarItem.title = "My Tasks"
        navigationController.tabBarItem.image = UIImage(systemName: "checkmark.circle")
        
        let presenter = resolver.resolve(TasksPresenter.self)!
        let screen = TasksListScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "My Tasks"
        
        navigationController.viewControllers = [viewController]
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .addTask:
                    self.showAddTaskScreen()
                case .taskSelected(let task):
                    // Handle task selection if needed
                    break
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showAddTaskScreen() {
        let addTaskCoordinator = resolver.resolve(
            AddTaskCoordinator.self,
            argument: navigationController
        )!
        
        addTaskCoordinator
            .start()
            .sink { [weak self] _ in
                // Refresh tasks list after adding
                if let presenter = self?.resolver.resolve(TasksPresenter.self) {
                    presenter.refreshTasks()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - About Me Editor Coordinator

class AboutMeEditorCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private(set) var editedAboutMe: String?
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let presenter = resolver.resolve(AboutMeEditorPresenter.self)!
        let screen = AboutMeEditorScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "Edit About Me"
        
        navigationController.pushViewController(viewController, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .finished(let aboutMe):
                    self.editedAboutMe = aboutMe
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// MARK: - Address Coordinator

class AddressCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let presenter = resolver.resolve(AddressPresenter.self)!
        let screen = AddressScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "Address"
        
        navigationController.pushViewController(viewController, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .editCity:
                    self.showCityEditor()
                case .editStreet:
                    self.showStreetEditor()
                case .backToProfile:
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
    
    private func showCityEditor() {
        let cityEditorCoordinator = resolver.resolve(
            CityEditorCoordinator.self,
            argument: navigationController
        )!
        
        cityEditorCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    private func showStreetEditor() {
        let streetEditorCoordinator = resolver.resolve(
            StreetEditorCoordinator.self,
            argument: navigationController
        )!
        
        streetEditorCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
    }
}

// MARK: - City Editor Coordinator

class CityEditorCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private(set) var editedCity: String?
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let presenter = resolver.resolve(CityEditorPresenter.self)!
        let screen = CityEditorScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "Edit City"
        
        navigationController.pushViewController(viewController, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .finished(let city):
                    self.editedCity = city
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// MARK: - Street Editor Coordinator

class StreetEditorCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private(set) var editedStreet: String?
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let presenter = resolver.resolve(StreetEditorPresenter.self)!
        let screen = StreetEditorScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "Edit Street"
        
        navigationController.pushViewController(viewController, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .finished(let street):
                    self.editedStreet = street
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// MARK: - Add Task Coordinator

class AddTaskCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private(set) var createdTask: Task?
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let presenter = resolver.resolve(AddTaskPresenter.self)!
        let screen = AddTaskScreen(presenter: presenter)
        let viewController = CustomHostingController(rootView: screen)
        viewController.title = "Add Task"
        
        navigationController.pushViewController(viewController, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        presenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .finished(let task):
                    self.createdTask = task
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// MARK: - Dependency Container Setup

class AppAssembly {
    static func createContainer() -> Container {
        let container = Container()
        
        // Register services
        container.register(UserServiceProtocol.self) { _ in UserService() }.inObjectScope(.container)
        container.register(NetworkServiceProtocol.self) { _ in NetworkService() }.inObjectScope(.container)
        container.register(TaskServiceProtocol.self) { _ in TaskService() }.inObjectScope(.container)
        
        // Register presenters
        container.register(ProfilePresenter.self) { _ in ProfilePresenter() }
        container.register(AboutMeEditorPresenter.self) { _ in AboutMeEditorPresenter() }
        container.register(AddressPresenter.self) { _ in AddressPresenter() }
        container.register(CityEditorPresenter.self) { _ in CityEditorPresenter() }
        container.register(StreetEditorPresenter.self) { _ in StreetEditorPresenter() }
        container.register(TasksPresenter.self) { r in
            TasksPresenter(taskService: r.resolve(TaskServiceProtocol.self)!)
        }
        container.register(AddTaskPresenter.self) { r in
            AddTaskPresenter(taskService: r.resolve(TaskServiceProtocol.self)!)
        }
        
        // Register coordinators
        container.register(HomeCoordinator.self) { (r, window: UIWindow) in
            HomeCoordinator(resolver: r, window: window)
        }
        
        container.register(ProfileCoordinator.self) { (r, navigationController: UINavigationController) in
            ProfileCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(AboutMeEditorCoordinator.self) { (r, navigationController: UINavigationController) in
            AboutMeEditorCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(AddressCoordinator.self) { (r, navigationController: UINavigationController) in
            AddressCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(CityEditorCoordinator.self) { (r, navigationController: UINavigationController) in
            CityEditorCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(StreetEditorCoordinator.self) { (r, navigationController: UINavigationController) in
            StreetEditorCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(TasksCoordinator.self) { (r, navigationController: UINavigationController) in
            TasksCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(AddTaskCoordinator.self) { (r, navigationController: UINavigationController) in
            AddTaskCoordinator(navigationController: navigationController, resolver: r)
        }
        
        return container
    }
}

// MARK: - Application Entry Point

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: HomeCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let container = AppAssembly.createContainer()
        appCoordinator = container.resolve(HomeCoordinator.self, argument: window!)
        appCoordinator?.start()
        
        return true
    }
}

// MARK: - Presenters

class ProfilePresenter {
    let output = PassthroughSubject<ProfilePresenterOutput, Never>()
    
    func editAboutMe() {
        output.send(.editAboutMe)
    }
    
    func editAddress() {
        output.send(.editAddress)
    }
}

class AboutMeEditorPresenter {
    let output = PassthroughSubject<AboutMeEditorPresenterOutput, Never>()
    
    func saveChanges(aboutMe: String) {
        output.send(.finished(aboutMe: aboutMe))
    }
    
    func cancel() {
        output.send(.finished(aboutMe: nil))
    }
}

class AddressPresenter {
    let output = PassthroughSubject<AddressPresenterOutput, Never>()
    
    func editCity() {
        output.send(.editCity)
    }
    
    func editStreet() {
        output.send(.editStreet)
    }
    
    func backToProfile() {
        output.send(.backToProfile)
    }
}

class CityEditorPresenter {
    let output = PassthroughSubject<CityEditorPresenterOutput, Never>()
    
    func saveChanges(city: String) {
        output.send(.finished(city: city))
    }
    
    func cancel() {
        output.send(.finished(city: nil))
    }
}

class StreetEditorPresenter {
    let output = PassthroughSubject<StreetEditorPresenterOutput, Never>()
    
    func saveChanges(street: String) {
        output.send(.finished(street: street))
    }
    
    func cancel() {
        output.send(.finished(street: nil))
    }
}

class TasksPresenter {
    private let taskService: TaskServiceProtocol
    let output = PassthroughSubject<TasksPresenterOutput, Never>()
    
    @Published var tasks: [Task] = []
    
    init(taskService: TaskServiceProtocol) {
        self.taskService = taskService
        refreshTasks()
    }
    
    func refreshTasks() {
        tasks = taskService.getAllTasks()
    }
    
    func addNewTask() {
        output.send(.addTask)
    }
    
    func taskSelected(_ task: Task) {
        output.send(.taskSelected(task))
    }
    
    func toggleTaskCompletion(_ task: Task) {
        taskService.toggleTaskCompletion(task)
        refreshTasks()
    }
}

class AddTaskPresenter {
    private let taskService: TaskServiceProtocol
    let output = PassthroughSubject<AddTaskPresenterOutput, Never>()
    
    init(taskService: TaskServiceProtocol) {
        self.taskService = taskService
    }
    
    func saveTask(title: String, description: String) {
        let newTask = Task(title: title, description: description)
        taskService.addTask(newTask)
        output.send(.finished(task: newTask))
    }
    
    func cancel() {
        output.send(.finished(task: nil))
    }
}

// MARK: - Services

protocol UserServiceProtocol {}
protocol NetworkServiceProtocol {}
protocol TaskServiceProtocol {
    func getAllTasks() -> [Task]
    func addTask(_ task: Task)
    func toggleTaskCompletion(_ task: Task)
}

class UserService: UserServiceProtocol {}
class NetworkService: NetworkServiceProtocol {}

class TaskService: TaskServiceProtocol {
    private var tasks: [Task] = [
        Task(title: "Buy groceries", description: "Get milk, eggs, and bread"),
        Task(title: "Pay bills", description: "Electricity and internet bills")
    ]
    
    func getAllTasks() -> [Task] {
        return tasks
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }
}

// MARK: - SwiftUI Views

struct ProfileScreen: View {
    let presenter: ProfilePresenter
    
    var body: some View {
        List {
            Section(header: Text("Personal Information")) {
                Button(action: { presenter.editAboutMe() }) {
                    HStack {
                        Text("About Me")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: { presenter.editAddress() }) {
                    HStack {
                        Text("Address")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct AboutMeEditorScreen: View {
    let presenter: AboutMeEditorPresenter
    @State private var aboutMe: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $aboutMe)
                .padding()
                .border(Color.gray, width: 1)
                .padding()
            
            HStack {
                Button("Cancel") {
                    presenter.cancel()
                }
                .padding()
                
                Spacer()
                
                Button("Save") {
                    presenter.saveChanges(aboutMe: aboutMe)
                }
                .padding()
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct AddressScreen: View {
    let presenter: AddressPresenter
    
    var body: some View {
        List {
            Button(action: { presenter.editCity() }) {
                HStack {
                    Text("City")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: { presenter.editStreet() }) {
                HStack {
                    Text("Street")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Done") {
            presenter.backToProfile()
        })
    }
}

struct CityEditorScreen: View {
    let presenter: CityEditorPresenter
    @State private var city: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $city)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Cancel") {
                    presenter.cancel()
                }
                .padding()
                
                Spacer()
                
                Button("Save") {
                    presenter.saveChanges(city: city)
                }
                .padding()
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct StreetEditorScreen: View {
    let presenter: StreetEditorPresenter
    @State private var street: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter street", text: $street)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Cancel") {
                    presenter.cancel()
                }
                .padding()
                
                Spacer()
                
                Button("Save") {
                    presenter.saveChanges(street: street)
                }
                .padding()
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct TasksListScreen: View {
    @ObservedObject private var presenter: TasksPresenter
    
    init(presenter: TasksPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        List {
            ForEach(presenter.tasks) { task in
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        presenter.toggleTaskCompletion(task)
                    }) {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isDone ? .green : .gray)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    presenter.taskSelected(task)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button(action: {
            presenter.addNewTask()
        }) {
            Image(systemName: "plus")
        })
    }
}

struct AddTaskScreen: View {
    let presenter: AddTaskPresenter
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            
            Section {
                Button("Save") {
                    presenter.saveTask(title: title, description: description)
                }
                .disabled(title.isEmpty)
                
                Button("Cancel") {
                    presenter.cancel()
                }
                .foregroundColor(.red)
            }
        }
    }
}

// MARK: - Helper Classes

class CustomHostingController<Content>: UIHostingController<Content> where Content: View {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Konfiguracja kontrolera hostującego SwiftUI
    }
}
