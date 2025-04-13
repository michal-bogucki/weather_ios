//
//  DetailsCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 11/04/2025.
//

import UIKit
import Combine
import Swinject

class DetailsCoordinator {
    
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private let locationService: LocationService
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.locationService = resolver.resolve(LocationService.self)!
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let detailsPresenter = resolver.resolve(
            DetailsPresenter.self,
            argument: DetailsPresenter.Input(
            locationSelectedInput: locationService.dailyForecastSelected,
            locationService: locationService
            )
        )!
        let detailsScreen = DetailsContainer(presenter: detailsPresenter)
        let detailsVC = CustomHostingController(rootView: detailsScreen)
        detailsVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(detailsVC, animated: true)
        
        let completionSubject = PassthroughSubject<Void, Never>()
        
        detailsPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                switch output {
                case .backToMain:
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(())
                    completionSubject.send(completion: .finished)
                    
                }
            } .store(in: &cancellables)
                
                
        return completionSubject.eraseToAnyPublisher()
       }
        
    
}
