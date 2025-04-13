//
//  TomorrowCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 27/03/2025.
//

import Combine
import Swinject
import UIKit

class TomorrowWeatherCoordinator {
    
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
        let tomorrowPresenter = resolver.resolve(
            TomorrowWeatherPresenter.self,
            argument: TomorrowWeatherPresenter.Input(
                locationSelectedInput: locationService.locationSelected,
                locationService: locationService
         )
        )!
        let tomorrowScreen = TomorrowScreenContainer(presenter: tomorrowPresenter)
        let tomorrowVC = CustomHostingController(rootView: tomorrowScreen)
        
        navigationController.viewControllers = [tomorrowVC]
        
        tomorrowPresenter.output
            .sink { output in
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                }
            }
            .store(in: &cancellables)
    
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}

private extension TomorrowWeatherCoordinator{
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
    private func removeChildCoordinator(_ coordinator: AnyObject) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
