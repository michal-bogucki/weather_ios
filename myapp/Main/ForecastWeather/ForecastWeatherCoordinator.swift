//
//  ForecastWeatherCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 08/04/2025.
//

import Combine
import Swinject
import UIKit

class ForecastWeatherCoordinator {
    
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private var childCoordinators: [AnyObject] = []
    private let locationService: LocationService
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.locationService = resolver.resolve(LocationService.self)!
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let forecastWeatherPresenter = resolver.resolve(
            ForecastWeatherPresenter.self,
            argument: ForecastWeatherPresenter.Input(
                locationSelectedInput: locationService.locationSelected,
                locationService: locationService
            )
       )!
        let forecastScreen = ForecastScreenContainer(presenter: forecastWeatherPresenter)
        let forecastViewController = CustomHostingController(rootView: forecastScreen)
        navigationController.viewControllers = [forecastViewController]
        
        forecastWeatherPresenter.output
            .sink { output in
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                case .openDetails(let location):
                    self.locationService.dailyForecastSelected.send(location)
                    self.showDetailsScreen()
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
}

private extension ForecastWeatherCoordinator {
    
        
        private func showSearchScreen() {
            let searchCoordinator = resolver.resolve(
                SearchCoordinator.self,
                argument: navigationController
            )!
            
            childCoordinators
                .append(searchCoordinator)
            
            searchCoordinator
                .start()
                .sink { [weak self] result in
                    self?.removeChildCoordinator(searchCoordinator)
                    switch result {
                    case .selected(let location):
                        self?.locationService.locationSelected.send(location)
                    case .cancelled:
                        // Opcjonalna obsługa anulowania
                        break
                    }
                }
                .store(in: &cancellables)
        }
    
        private func showDetailsScreen() {
            let detailsCoordinator = resolver.resolve(
                DetailsCoordinator.self,
                argument: navigationController
            )!
            
            childCoordinators
                .append(detailsCoordinator)
            
            detailsCoordinator
                .start()
                .sink { [weak self] result in
                    self?.removeChildCoordinator(detailsCoordinator)
                }
                .store(in: &cancellables)
            
        }
        
        private func removeChildCoordinator(_ coordinator: AnyObject) {
            if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
                childCoordinators.remove(at: index)
            }
        }
}

