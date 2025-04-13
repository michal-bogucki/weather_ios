//
//  TodayWeatherCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 20/03/2025.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import Swinject

class TodayWeatherCoordinator {
  
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var canncellables = Set<AnyCancellable>()
    private var childCoordinators: [AnyObject] = []
    private let locationService: LocationService
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.locationService = resolver.resolve(LocationService.self)!
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let todayWeatherPresenter = resolver.resolve(
            TodayWeatherPresenter.self,
            argument: TodayWeatherPresenter.Input(
                locationSelectedInput: locationService.locationSelected,
                locationService: locationService
            )
        )!
        let todayScreen = TodayScreenContainer(presenter: todayWeatherPresenter)
        let todayViewController = CustomHostingController(rootView: todayScreen)
        navigationController.viewControllers = [todayViewController]
        
        todayWeatherPresenter.output
            .sink { output in
                switch output {
                case .searchTapped:
                    self.showSearchScreen()
                case .showMore:
                    break
                }
            }
            .store(in: &canncellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
}

private extension TodayWeatherCoordinator {
    
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
            .store(in: &canncellables)
    }
    
    private func removeChildCoordinator(_ coordinator: AnyObject) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
