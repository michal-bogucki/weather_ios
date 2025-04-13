// ===================================================================================
// Application Layer
// ===================================================================================

// File: WeatherApp.swift
import SwiftUI
import UIKit

@main
struct WeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            // This view won't actually be used since we're managing navigation via UIKit
            Color.clear.ignoresSafeArea()
        }
    }
}

// File: AppDelegate.swift
import UIKit
import Swinject

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: WeatherAppCoordinator?
    
    func application(_ application: UIApplication, didFinLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let container = DependencyContainer.shared.container
        appCoordinator = container.resolve(WeatherAppCoordinator.self, argument: window!)
        appCoordinator?.start()
        
        return true
    }
}

// File: Dependencies/DependencyContainer.swift
import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    
    let container: Container
    
    private init() {
        container = Container()
        registerServices()
        registerPresenters()
        registerCoordinators()
    }
    
    private func registerServices() {
        container.register(WeatherServiceProtocol.self) { _ in
            WeatherService()
        }.inObjectScope(.container)
    }
    
    private func registerPresenters() {
        // Today Screen Presenter
        container.register(TodayPresenter.self) { r in
            TodayPresenter(weatherService: r.resolve(WeatherServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        // Tomorrow Screen Presenter
        container.register(TomorrowPresenter.self) { r in
            TomorrowPresenter(weatherService: r.resolve(WeatherServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        // Forecast Screen Presenter
        container.register(ForecastPresenter.self) { r in
            ForecastPresenter(weatherService: r.resolve(WeatherServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        // Search Screen Presenter
        container.register(SearchPresenter.self) { r in
            SearchPresenter(weatherService: r.resolve(WeatherServiceProtocol.self)!)
        }
        
        // Day Detail Presenter
        container.register(DayDetailPresenter.self) { (r, day: DailyForecast) in
            DayDetailPresenter(day: day, weatherService: r.resolve(WeatherServiceProtocol.self)!)
        }
    }
    
    private func registerCoordinators() {
        // Main App Coordinator
        container.register(WeatherAppCoordinator.self) { (r, window: UIWindow) in
            WeatherAppCoordinator(resolver: r, window: window)
        }
        
        // Tab Coordinators
        container.register(TodayCoordinator.self) { (r, navigationController: UINavigationController) in
            TodayCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(TomorrowCoordinator.self) { (r, navigationController: UINavigationController) in
            TomorrowCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(ForecastCoordinator.self) { (r, navigationController: UINavigationController) in
            ForecastCoordinator(navigationController: navigationController, resolver: r)
        }
        
        // Other Coordinators
        container.register(SearchCoordinator.self) { (r, navigationController: UINavigationController) in
            SearchCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(DayDetailCoordinator.self) { (r, navigationController: UINavigationController, day: DailyForecast) in
            DayDetailCoordinator(navigationController: navigationController, resolver: r, day: day)
        }
    }
}

// ===================================================================================
// Domain Layer - Models and Services
// ===================================================================================

// File: Models/WeatherModels.swift
import SwiftUI
import CoreLocation

struct WeatherLocation: Identifiable {
    let id: Int
    let name: String
    let country: String
    let date: String
    let temp: Int
    let feels: Int
    let condition: WeatherCondition
    let high: Int
    let low: Int
    let humidity: Int
    let wind: Int
    let windDirection: String
    let pressure: Int
    let uvIndex: Int
    let visibility: Double
    let airQuality: String
    let sunrise: String
    let sunset: String
    let moonPhase: String
    let precipitation: Int
    let hourlyForecast: [HourlyForecast]
    let weeklyForecast: [DailyForecast]
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let hour: String
    let temp: Int
    let condition: WeatherCondition
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let high: Int
    let low: Int
    let condition: WeatherCondition
}

// File: Services/WeatherServiceProtocol.swift
import Foundation

protocol WeatherServiceProtocol {
    func getCurrentLocation() -> WeatherLocation
    func getWeatherForLocation(id: Int) -> WeatherLocation
    func searchLocations(query: String) -> [WeatherLocation]
}

// File: Services/WeatherService.swift
import Foundation

class WeatherService: WeatherServiceProtocol {
    func getCurrentLocation() -> WeatherLocation {
        return sampleData[0]
    }
    
    func getWeatherForLocation(id: Int) -> WeatherLocation {
        return sampleData.first { $0.id == id } ?? sampleData[0]
    }
    
    func searchLocations(query: String) -> [WeatherLocation] {
        if query.isEmpty {
            return sampleData
        }
        
        return sampleData.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.country.lowercased().contains(query.lowercased())
        }
    }
}

// ===================================================================================
// Presentation Layer - Coordinators
// ===================================================================================

// File: Coordinators/WeatherAppCoordinator.swift
import UIKit
import Combine
import Swinject

class WeatherAppCoordinator {
    private let resolver: Resolver
    private let window: UIWindow
    
    private var cancellables = [AnyCancellable]()
    
    init(resolver: Resolver, window: UIWindow) {
        self.resolver = resolver
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        let todayNavController = makeToday()
        let tomorrowNavController = makeTomorrow()
        let forecastNavController = makeForecast()
        
        // Configure tab bar
        tabBarController.setViewControllers([todayNavController, tomorrowNavController, forecastNavController], animated: false)
        
        // Apply styling to tab bar
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension WeatherAppCoordinator {
    func makeToday() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), tag: 0)
        
        let todayCoordinator = resolver.resolve(
            TodayCoordinator.self,
            argument: navigationController
        )!
        
        todayCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeTomorrow() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Tomorrow", image: UIImage(systemName: "calendar"), tag: 1)
        
        let tomorrowCoordinator = resolver.resolve(
            TomorrowCoordinator.self,
            argument: navigationController
        )!
        
        tomorrowCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeForecast() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 2)
        
        let forecastCoordinator = resolver.resolve(
            ForecastCoordinator.self,
            argument: navigationController
        )!
        
        forecastCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
}

// File: Coordinators/TodayCoordinator.swift
import UIKit
import Combine
import Swinject

class TodayCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let todayPresenter = resolver.resolve(TodayPresenter.self)!
        let todayScreen = TodayScreenContainer(presenter: todayPresenter)
        let todayVC = CustomHostingController(rootView: todayScreen)
        
        navigationController.viewControllers = [todayVC]
        
        todayPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                case .showMore:
                    // No navigation needed, handled within the presenter
                    break
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showSearchScreen() {
        let searchCoordinator = resolver.resolve(
            SearchCoordinator.self,
            argument: navigationController
        )!
        
        searchCoordinator
            .start()
            .sink { [weak self] _ in
                // Refresh today's weather data after returning from search
                if let todayPresenter = self?.resolver.resolve(TodayPresenter.self) {
                    todayPresenter.refreshWeatherData()
                }
            }
            .store(in: &cancellables)
    }
}

// File: Coordinators/TomorrowCoordinator.swift
import UIKit
import Combine
import Swinject

class TomorrowCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let tomorrowPresenter = resolver.resolve(TomorrowPresenter.self)!
        let tomorrowScreen = TomorrowScreenContainer(presenter: tomorrowPresenter)
        let tomorrowVC = CustomHostingController(rootView: tomorrowScreen)
        
        navigationController.viewControllers = [tomorrowVC]
        
        tomorrowPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showSearchScreen() {
        let searchCoordinator = resolver.resolve(
            SearchCoordinator.self,
            argument: navigationController
        )!
        
        searchCoordinator
            .start()
            .sink { [weak self] _ in
                // Refresh tomorrow's weather data after returning from search
                if let tomorrowPresenter = self?.resolver.resolve(TomorrowPresenter.self) {
                    tomorrowPresenter.refreshWeatherData()
                }
            }
            .store(in: &cancellables)
    }
}

// File: Coordinators/ForecastCoordinator.swift
import UIKit
import Combine
import Swinject

class ForecastCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let forecastPresenter = resolver.resolve(ForecastPresenter.self)!
        let forecastScreen = ForecastScreenContainer(presenter: forecastPresenter)
        let forecastVC = CustomHostingController(rootView: forecastScreen)
        
        navigationController.viewControllers = [forecastVC]
        
        forecastPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                case .selectDay(let day):
                    self.showDayDetail(day: day)
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showSearchScreen() {
        let searchCoordinator = resolver.resolve(
            SearchCoordinator.self,
            argument: navigationController
        )!
        
        searchCoordinator
            .start()
            .sink { [weak self] _ in
                // Refresh forecast data after returning from search
                if let forecastPresenter = self?.resolver.resolve(ForecastPresenter.self) {
                    forecastPresenter.refreshWeatherData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func showDayDetail(day: DailyForecast) {
        let dayDetailCoordinator = resolver.resolve(
            DayDetailCoordinator.self,
            arguments: navigationController, day
        )!
        
        dayDetailCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
    }
}

// File: Coordinators/SearchCoordinator.swift
import UIKit
import Combine
import Swinject

class SearchCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let searchPresenter = resolver.resolve(SearchPresenter.self)!
        let searchScreen = SearchContainer(presenter: searchPresenter)
        let searchVC = CustomHostingController(rootView: searchScreen)
        
        // Hide tab bar when showing search screen
        searchVC.hidesBottomBarWhenPushed = true
        
        navigationController.pushViewController(searchVC, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        searchPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .backToMain:
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                    
                case .citySelected(let location):
                    // Update location in all presenters
                    if let todayPresenter = self.resolver.resolve(TodayPresenter.self) {
                        todayPresenter.setSelectedLocation(location)
                    }
                    if let tomorrowPresenter = self.resolver.resolve(TomorrowPresenter.self) {
                        tomorrowPresenter.setSelectedLocation(location)
                    }
                    if let forecastPresenter = self.resolver.resolve(ForecastPresenter.self) {
                        forecastPresenter.setSelectedLocation(location)
                    }
                    
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// File: Coordinators/DayDetailCoordinator.swift
import UIKit
import Combine
import Swinject

class DayDetailCoordinator {
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private let day: DailyForecast
    
    init(navigationController: UINavigationController, resolver: Resolver, day: DailyForecast) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.day = day
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let dayDetailPresenter = resolver.resolve(DayDetailPresenter.self, arguments: day)!
        let dayDetailScreen = DayDetailContainer(presenter: dayDetailPresenter)
        let dayDetailVC = CustomHostingController(rootView: dayDetailScreen)
        
        // Hide tab bar when showing day detail
        dayDetailVC.hidesBottomBarWhenPushed = true
        
        navigationController.pushViewController(dayDetailVC, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        dayDetailPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                
                switch output {
                case .backToForecast:
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                }
            }
            .store(in: &cancellables)
        
        return completionSubject.eraseToAnyPublisher()
    }
}

// ===================================================================================
// Presentation Layer - Presenters
// ===================================================================================

// File: Presenters/TodayPresenter.swift
import Combine
import SwiftUI

class TodayPresenter: ObservableObject {
    enum Output {
        case searchTapped
        case showMore
    }
    
    @Published var currentOutput: Output?
    @Published var selectedLocation: WeatherLocation
    @Published var showMore: Bool = false
    
    lazy var output = makeOutput().share()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    let didTapShowMore = PassthroughSubject<Void, Never>()
    let didSetLocation = PassthroughSubject<WeatherLocation, Never>()
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.selectedLocation = sampleData[0]
        
        setupBindings()
    }
    
    func setSelectedLocation(_ location: WeatherLocation) {
        didSetLocation.send(location)
    }
    
    func refreshWeatherData() {
        // In a real app, this would refresh the weather data for the current location
    }
}

private extension TodayPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapSearch.map { _ in Output.searchTapped },
            didTapShowMore.map { _ in Output.showMore }
        )
        .eraseToAnyPublisher()
    }
    
    func setupBindings() {
        didSetLocation
            .assign(to: \.selectedLocation, on: self)
            .store(in: &cancellables)
        
        didTapShowMore
            .map { [unowned self] _ in !self.showMore }
            .assign(to: \.showMore, on: self)
            .store(in: &cancellables)
    }
}

// File: Presenters/TomorrowPresenter.swift
import Combine
import SwiftUI

class TomorrowPresenter: ObservableObject {
    enum Output {
        case searchTapped
    }
    
    @Published var currentOutput: Output?
    @Published var selectedLocation: WeatherLocation
    
    lazy var output = makeOutput().share()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    let didSetLocation = PassthroughSubject<WeatherLocation, Never>()
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.selectedLocation = sampleData[0]
        
        setupBindings()
    }
    
    func setSelectedLocation(_ location: WeatherLocation) {
        didSetLocation.send(location)
    }
    
    func refreshWeatherData() {
        // In a real app, this would refresh the weather data for the current location
    }
}

private extension TomorrowPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        didTapSearch
            .map { _ in Output.searchTapped }
            .eraseToAnyPublisher()
    }
    
    func setupBindings() {
        didSetLocation
            .assign(to: \.selectedLocation, on: self)
            .store(in: &cancellables)
    }
}

// File: Presenters/ForecastPresenter.swift
import Combine
import SwiftUI

class ForecastPresenter: ObservableObject {
    enum Output {
        case searchTapped
        case selectDay(DailyForecast)
    }
    
    @Published var currentOutput: Output?
    @Published var selectedLocation: WeatherLocation
    
    lazy var output = makeOutput().share()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    let didSelectDay = PassthroughSubject<DailyForecast, Never>()
    let didSetLocation = PassthroughSubject<WeatherLocation, Never>()
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.selectedLocation = sampleData[0]
        
        setupBindings()
    }
    
    func setSelectedLocation(_ location: WeatherLocation) {
        didSetLocation.send(location)
    }
    
    func refreshWeatherData() {
        // In a real app, this would refresh the weather data for the current location
    }
}

private extension ForecastPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapSearch.map { _ in Output.searchTapped },
            didSelectDay.map { Output.selectDay($0) }
        )
        .eraseToAnyPublisher()
    }
    
    func setupBindings() {
        didSetLocation
            .assign(to: \.selectedLocation, on: self)
            .store(in: &cancellables)
    }
}

// File: Presenters/SearchPresenter.swift
import Combine
import SwiftUI

class SearchPresenter: ObservableObject {
    enum Output {
        case backToMain
        case citySelected(WeatherLocation)
    }
    
    @Published var currentOutput: Output?
    @Published var recentLocations: [WeatherLocation]
    @Published var searchText: String = ""
    
    lazy var output = makeOutput().share()
    
    let didTapBack = PassthroughSubject<Void, Never>()
    let didSelectCity = PassthroughSubject<WeatherLocation, Never>()
    let didChangeSearchText = PassthroughSubject<String, Never>()
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.recentLocations = sampleData
        
        setupBindings()
    }
}

private extension SearchPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapBack.map { _ in Output.backToMain },
            didSelectCity.map { Output.citySelected($0) }
        )
        .eraseToAnyPublisher()
    }
    
    func setupBindings() {
        didChangeSearchText
            .assign(to: \.searchText, on: self)
            .store(in: &cancellables)
        
        didChangeSearchText
            .map { [weak self] text in
                guard let self = self else { return sampleData }
                if text.isEmpty {
                    return sampleData
                }
                return self.weatherService.searchLocations(query: text)
            }
            .assign(to: \.recentLocations, on: self)
            .store(in: &cancellables)
    }
}

// File: Presenters/DayDetailPresenter.swift
import Combine
import SwiftUI

class DayDetailPresenter: ObservableObject {
    enum Output {
        case backToForecast
    }
    
    @Published var currentOutput: Output?
    @Published var day: DailyForecast
    @Published var location: WeatherLocation
    
    lazy var output = makeOutput().share()
    
    let didTapBack = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(day: DailyForecast, weatherService: WeatherServiceProtocol) {
        self.day = day
        
        // Find the location that has this day in its forecast
        let matchingLocation = sampleData.first { location in
            location.weeklyForecast.contains { forecastDay in
                forecastDay.day == day.day
            }
        } ?? sampleData[0]
        
        self.location = matchingLocation
    }
}

private extension DayDetailPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        didTapBack
            .map { _ in Output.backToForecast }
            .eraseToAnyPublisher()
    }
}

// ===================================================================================
// Presentation Layer - View Containers
// ===================================================================================

// File: Views/TodayScreenContainer.swift
import SwiftUI
import Combine

struct TodayScreenContainer: View {
    @ObservedObject var presenter: TodayPresenter
    
    var body: some View {
        // Your TodayView will go here
        // This is just a placeholder structure
        ZStack {
            // Background color based on weather condition
            presenter.selectedLocation.condition.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top navigation buttons
                HStack {
                    Spacer()
                    
                    Button(action: { presenter.didTapSearch.send() }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(presenter.selectedLocation.condition.textColor.opacity(0.4), lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                
                // Today Screen Content placeholder
                Text("Today Screen")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(presenter.selectedLocation.condition.textColor)
                
                // Show More button
                Button(action: { presenter.didTapShowMore.send() }) {
                    Text(presenter.showMore ? "Show Less" : "Show More")
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                }
                
                if presenter.showMore {
                    // Additional content when "Show More" is active
                    VStack(spacing: 15) {
                        Text("Additional Weather Details")
                            .font(.headline)
                        Text("Humidity: \(presenter.selectedLocation.humidity)%")
                        Text("Wind: \(presenter.selectedLocation.wind) mph \(presenter.selectedLocation.windDirection)")
                        Text("Pressure: \(presenter.selectedLocation.pressure) hPa")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
            }
            .foregroundColor(presenter.selectedLocation.condition.textColor)
        }
    }
}

// File: Views/TomorrowScreenContainer.swift
import SwiftUI
import Combine

struct TomorrowScreenContainer: View {
    @ObservedObject var presenter: TomorrowPresenter
    
    var body: some View {
        // Your TomorrowView will go here
        // This is just a placeholder structure
        ZStack {
            // Background color based on weather condition
            presenter.selectedLocation.condition.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top navigation buttons
                HStack {
                    Spacer()
                    
                    Button(action: { presenter.didTapSearch.send() }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(presenter.selectedLocation.condition.textColor.opacity(0.4), lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                
                // Tomorrow Screen Content placeholder
                Text("Tomorrow Screen")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(presenter.selectedLocation.condition.textColor)
                
                Spacer()
            }
            .foregroundColor(presenter.selectedLocation.condition.textColor)
        }
    }
}

// File: Views/ForecastScreenContainer.swift
import SwiftUI
import Combine

struct ForecastScreenContainer: View {
    @ObservedObject var presenter: ForecastPresenter
    
    var body: some View {
        // Your ForecastView will go here
        // This is just a placeholder structure
        ZStack {
            // Background color based on weather condition
            presenter.selectedLocation.condition.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top navigation buttons
                HStack {
                    Spacer()
                    
                    Button(action: { presenter.didTapSearch.send() }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(presenter.selectedLocation.condition.textColor.opacity(0.4), lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                
                // Forecast Screen Content placeholder - Note that you'll implement the actual views
                Text("Forecast Screen")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(presenter.selectedLocation.condition.textColor)
                
                // Example of forecast day list that would trigger day selection
                VStack(spacing: 12) {
                    ForEach(presenter.selectedLocation.weeklyForecast) { day in
                        Button(action: {
                            presenter.didSelectDay.send(day)
                        }) {
                            Text(day.day)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .foregroundColor(presenter.selectedLocation.condition.textColor)
        }
    }
}

// File: Views/SearchContainer.swift
import SwiftUI
import Combine

struct SearchContainer: View {
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header with back button
            HStack {
                Button(action: { presenter.didTapBack.send() }) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                        
                        Text("Search Location")
                            .font(.system(size: 20, weight: .light))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding(20)
            .padding(.top, 50)
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("5D87FF"))
                    .padding(.leading, 8)
                
                TextField("Search for a city...", text: Binding(
                    get: { presenter.searchText },
                    set: { presenter.didChangeSearchText.send($0) }
                ))
                .padding(.vertical, 12)
                .foregroundColor(Color("333333"))
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            // Recent searches
            Text("Recent Searches")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("333333"))
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            ForEach(presenter.recentLocations) { loc in
                Button(action: { presenter.didSelectCity.send(loc) }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(loc.name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("333333"))
                            Text(loc.country)
                                .font(.system(size: 14))
                                .foregroundColor(Color("666666"))
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            MiniWeatherArtView(condition: loc.condition, size: 24)
                                .frame(width: 24, height: 24)
                            
                            Text("\(loc.temp)°")
                                .font(.system(size: 20, weight: .light))
                                .foregroundColor(Color("333333"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .buttonStyle(PlainButtonStyle())
            }
            
            // Popular cities
            Text("Popular Cities")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("333333"))
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(["Paris", "London", "New York", "Tokyo", "Sydney", "Dubai"], id: \.self) { city in
                    Button(action: {
                        if let location = presenter.recentLocations.first(where: { $0.name == city }) {
                            presenter.didSelectCity.send(location)
                        } else if let location = sampleData.first(where: { $0.name == city }) {
                            presenter.didSelectCity.send(location)
                        }
                    }) {
                        Text(city)
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundColor(Color("5D87FF"))
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color("F5F5F5"))
        .edgesIgnoringSafeArea(.all)
    }
}

// File: Views/DayDetailContainer.swift
import SwiftUI
import Combine

struct DayDetailContainer: View {
    @ObservedObject var presenter: DayDetailPresenter
    
    var body: some View {
        // Your DayDetailView will go here
        // This is just a placeholder structure
        ZStack {
            // Background color based on weather condition
            presenter.day.condition.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header with back button
                HStack {
                    Button(action: { presenter.didTapBack.send() }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16))
                            
                            Text(presenter.day.day)
                                .font(.system(size: 20, weight: .light))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding(20)
                .padding(.top, 50)
                
                // Day Detail placeholder
                VStack(spacing: 20) {
                    Text(presenter.day.day)
                        .font(.system(size: 28, weight: .bold))
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("High")
                            Text("\(presenter.day.high)°")
                                .font(.system(size: 20, weight: .medium))
                        }
                        
                        VStack {
                            Text("Low")
                            Text("\(presenter.day.low)°")
                                .font(.system(size: 20, weight: .medium))
                        }
                    }
                    
                    // Weather condition image placeholder
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Text(presenter.day.condition.rawValue)
                                .font(.system(size: 14))
                        )
                }
                .padding()
                
                Spacer()
            }
            .foregroundColor(presenter.day.condition.textColor)
        }
    }
}

// File: Utils/CustomHostingController.swift
import SwiftUI
import UIKit

class CustomHostingController<Content>: UIHostingController<Content> where Content: View {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the default navigation bar since we're using custom navigation
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// ===================================================================================
// Helper Extensions and Utilities
// ===================================================================================

// Helper extension for Color from hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Placeholder for weather condition enum
enum WeatherCondition: String {
    case sunny = "sunny"
    case cloudy = "cloudy"
    case rainy = "rainy"
    case snowy = "snowy"
    case stormy = "stormy"
    case partlyCloudy = "partly_cloudy"
    
    var backgroundColor: Color {
        switch self {
        case .sunny: return Color(hex: "5D87FF")
        case .cloudy: return Color(hex: "778899")
        case .rainy: return Color(hex: "4682B4")
        case .snowy: return Color(hex: "B0C4DE")
        case .stormy: return Color(hex: "483D8B")
        case .partlyCloudy: return Color(hex: "6495ED")
        }
    }
    
    var textColor: Color {
        switch self {
        case .sunny, .cloudy, .rainy, .stormy, .partlyCloudy: return .white
        case .snowy: return Color(hex: "333333")
        }
    }
}

// Placeholder for MiniWeatherArtView
struct MiniWeatherArtView: View {
    let condition: WeatherCondition
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(condition.backgroundColor)
                .frame(width: size, height: size)
            
            // Simple icon based on condition
            Group {
                switch condition {
                case .sunny:
                    Image(systemName: "sun.max.fill")
                case .cloudy:
                    Image(systemName: "cloud.fill")
                case .rainy:
                    Image(systemName: "cloud.rain.fill")
                case .snowy:
                    Image(systemName: "snow")
                case .stormy:
                    Image(systemName: "cloud.bolt.fill")
                case .partlyCloudy:
                    Image(systemName: "cloud.sun.fill")
                }
            }
            .font(.system(size: size * 0.6))
            .foregroundColor(.white)
        }
    }
}

// Placeholder for sample data
let sampleData: [WeatherLocation] = [
    WeatherLocation(
        id: 1,
        name: "New York",
        country: "USA",
        date: "Monday, March 20",
        temp: 18,
        feels: 16,
        condition: .sunny,
        high: 20,
        low: 12,
        humidity: 45,
        wind: 10,
        windDirection: "NE",
        pressure: 1015,
        uvIndex: 5,
        visibility: 10.0,
        airQuality: "Good",
        sunrise: "6:45 AM",
        sunset: "7:30 PM",
        moonPhase: "Waxing Crescent",
        precipitation: 0,
        hourlyForecast: [
            HourlyForecast(hour: "Now", temp: 18, condition: .sunny),
            HourlyForecast(hour: "1 PM", temp: 19, condition: .sunny),
            HourlyForecast(hour: "2 PM", temp: 20, condition: .sunny),
            HourlyForecast(hour: "3 PM", temp: 20, condition: .sunny),
            HourlyForecast(hour: "4 PM", temp: 19, condition: .partlyCloudy),
            HourlyForecast(hour: "5 PM", temp: 18, condition: .partlyCloudy),
            HourlyForecast(hour: "6 PM", temp: 16, condition: .partlyCloudy),
            HourlyForecast(hour: "7 PM", temp: 15, condition: .cloudy)
        ],
        weeklyForecast: [
            DailyForecast(day: "Today", high: 20, low: 12, condition: .sunny),
            DailyForecast(day: "Tomorrow", high: 22, low: 14, condition: .partlyCloudy),
            DailyForecast(day: "Wednesday", high: 19, low: 13, condition: .cloudy),
            DailyForecast(day: "Thursday", high: 18, low: 12, condition: .rainy),
            DailyForecast(day: "Friday", high: 16, low: 10, condition: .rainy),
            DailyForecast(day: "Saturday", high: 17, low: 11, condition: .partlyCloudy),
            DailyForecast(day: "Sunday", high: 19, low: 12, condition: .sunny)
        ]
    ),
    WeatherLocation(
        id: 2,
        name: "London",
        country: "UK",
        date: "Monday, March 20",
        temp: 14,
        feels: 12,
        condition: .rainy,
        high: 15,
        low: 10,
        humidity: 75,
        wind: 15,
        windDirection: "SW",
        pressure: 1008,
        uvIndex: 2,
        visibility: 8.0,
        airQuality: "Moderate",
        sunrise: "6:15 AM",
        sunset: "6:45 PM",
        moonPhase: "Waxing Gibbous",
        precipitation: 65,
        hourlyForecast: [
            HourlyForecast(hour: "Now", temp: 14, condition: .rainy),
            HourlyForecast(hour: "1 PM", temp: 14, condition: .rainy),
            HourlyForecast(hour: "2 PM", temp: 15, condition: .rainy),
            HourlyForecast(hour: "3 PM", temp: 15, condition: .cloudy),
            HourlyForecast(hour: "4 PM", temp: 14, condition: .cloudy),
            HourlyForecast(hour: "5 PM", temp: 13, condition: .cloudy),
            HourlyForecast(hour: "6 PM", temp: 12, condition: .cloudy),
            HourlyForecast(hour: "7 PM", temp: 11, condition: .cloudy)
        ],
        weeklyForecast: [
            DailyForecast(day: "Today", high: 15, low: 10, condition: .rainy),
            DailyForecast(day: "Tomorrow", high: 16, low: 11, condition: .cloudy),
            DailyForecast(day: "Wednesday", high: 14, low: 9, condition: .cloudy),
            DailyForecast(day: "Thursday", high: 13, low: 8, condition: .rainy),
            DailyForecast(day: "Friday", high: 12, low: 7, condition: .rainy),
            DailyForecast(day: "Saturday", high: 14, low: 9, condition: .cloudy),
            DailyForecast(day: "Sunday", high: 15, low: 10, condition: .partlyCloudy)
        ]
    )
]
