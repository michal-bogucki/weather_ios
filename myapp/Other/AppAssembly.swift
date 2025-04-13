//
//  AppAssembly.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import Swinject
import UIKit

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(WeatherAppCoordinator.self) { r in
            guard let window = UIApplication.shared.delegate?.window ?? nil else {
                fatalError("Oops")
            }
            
            return WeatherAppCoordinator(
                resolver: r,
                window: window
            )
        }
        
        container.register(TodayWeatherCoordinator.self) { (r,navigationController:UINavigationController) in
            TodayWeatherCoordinator(navigationController:
               navigationController, resolver: r)
        }
        
        container.register(TodayWeatherPresenter.self) { r, input in
            TodayWeatherPresenter(input: input)
        }
//        .inObjectScope(.container) // example
        
        container.register(TomorrowWeatherCoordinator.self) {
            (r,navigationController:UINavigationController) in
            TomorrowWeatherCoordinator(navigationController: navigationController, resolver: r)
            
        }
        
        container.register(TomorrowWeatherPresenter.self) { r , input in
            TomorrowWeatherPresenter(input: input)
        }
        
        container.register(SearchCoordinator.self) {
            (r,navigationController:UINavigationController) in
            SearchCoordinator(navigationController: navigationController, resolver: r)
        }
        
        container.register(SearchPresenter.self) { r , input in
            SearchPresenter(input: input)
        }
        
        container.register(LocationService.self) { _ in
            return LocationService.shared
        }
        
        container.register(ForecastWeatherCoordinator.self) {
            (r , navigationController:UINavigationController) in
            ForecastWeatherCoordinator(
                navigationController: navigationController,
                resolver: r
            )
        }
        
        container.register(ForecastWeatherPresenter.self) { r , input in
            ForecastWeatherPresenter(input: input)
        }
        
        container.register(DetailsCoordinator.self) {
            (r , navigationController:UINavigationController) in
            DetailsCoordinator(
                navigationController: navigationController,
                resolver: r
            )
        }
        
        container.register(DetailsPresenter.self) { r , input in
            DetailsPresenter(input: input)
        }
        
    }
}
