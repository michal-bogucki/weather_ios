//
//  WeatherAppCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 20/03/2025.
//

import UIKit
import Combine
import Swinject

class WeatherAppCoordinator {
    private let resolver: Resolver
    private let window: UIWindow
    private var cancellables = [AnyCancellable]()
    private let locationService: LocationService
    
    private var childCoordinators: [AnyObject] = []
    
    init(resolver: Resolver,window: UIWindow) {
        self.resolver = resolver
        self.window = window
        self.locationService = resolver.resolve(LocationService.self)!
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let todayWeather = makeTodayWeatherCoordinator()
        let tomorrowWeather = makeTomorrowWeatherCoordinator()
        let forecastWeather = makeForecastWeatherCoordinator()
        
        todayWeather.tabBarItem = UITabBarItem(
            title: "Today",
            image: UIImage(systemName: "thermometer.sun"),
            selectedImage: UIImage(systemName: "thermometer.sun.fill")
        )

        tomorrowWeather.tabBarItem = UITabBarItem(
            title: "Tomorrow",
            image: UIImage(systemName: "cloud.sun"),
            selectedImage: UIImage(systemName: "cloud.sun.fill")
        )

        forecastWeather.tabBarItem = UITabBarItem(
            title: "Forecast",
            image: UIImage(systemName: "calendar.badge.clock"),
            selectedImage: UIImage(systemName: "calendar.badge.exclamationmark")
        )

        
        tabBarController.setViewControllers([todayWeather, tomorrowWeather, forecastWeather], animated: false)
        
        if let defaultLocation = locationService.sampleWeather.first {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(defaultLocation.condition.backgroundColor)
            
            // Zwiększ rozmiar czcionki
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium), // Zwiększony rozmiar
                .foregroundColor: UIColor(defaultLocation.condition.textColor)
            ]
            
            let selectedTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .bold), // Pogrubiona dla wybranej zakładki
                .foregroundColor: UIColor(defaultLocation.condition.textColor)
            ]
            
            // Zastosuj atrybuty do wszystkich stanów
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = textAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes
            
            // Dostosuj rozmiar ikon (opcjonalnie)
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(defaultLocation.condition.textColor.opacity(0.7))
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(defaultLocation.condition.textColor)
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        // Nasłuchuj zmian lokalizacji
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("weatherLocationChanged"),
            object: nil,
            queue: .main
        ) { [weak tabBarController] notification in
            if let location = notification.object as? WeatherLocation {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(location.condition.backgroundColor)
             
                tabBarController?.tabBar.standardAppearance = appearance
                tabBarController?.tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
    
}

private extension WeatherAppCoordinator{
    
    func makeTodayWeatherCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let todayWeatherCoordinator = resolver.resolve(
            TodayWeatherCoordinator.self,
            argument: navigationController
        )!
        
        childCoordinators.append(todayWeatherCoordinator)
        
        todayWeatherCoordinator
            .start()
            .sink {_ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeTomorrowWeatherCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let tomorrowCoordinator = resolver.resolve(
            TomorrowWeatherCoordinator.self,
            argument: navigationController
        )!
        
        childCoordinators.append(tomorrowCoordinator)
        
        tomorrowCoordinator
            .start()
            .sink {_ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeForecastWeatherCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let forecastCoordinator = resolver.resolve(
            ForecastWeatherCoordinator.self,
            argument: navigationController
        )!
        
        childCoordinators.append(forecastCoordinator)
        
        forecastCoordinator
            .start()
            .sink {_ in }
            .store(in: &cancellables)
        
        return navigationController
    }
}
