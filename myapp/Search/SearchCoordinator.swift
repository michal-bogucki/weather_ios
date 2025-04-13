//
//  SearchCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 27/03/2025.
//
import UIKit
import Combine
import Swinject

class SearchCoordinator {
    
    enum SearchResult {
        case selected(WeatherLocation)
        case cancelled
    }
    
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    private let locationService: LocationService
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.locationService = resolver.resolve(LocationService.self)!
    }
    
    func start() -> AnyPublisher<SearchResult, Never> {
        let searchPresenter = resolver.resolve(SearchPresenter.self)!
        let searchScreen = SearchContainer(presenter: searchPresenter)
        let searchVC = CustomHostingController(rootView: searchScreen)
        searchVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(searchVC, animated: true)
        
        let completionSubject = PassthroughSubject<SearchResult, Never>()
        
        searchPresenter.output
            .sink { [weak self] output in
                guard let self = self else { return }
                switch output {
                case .backToMain:
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(.cancelled)
                    completionSubject.send(completion: .finished)
                    
                    
                case .citySearch(let location):
                    self.locationService.locationSelected.send(location)
                    self.navigationController.popViewController(animated: true)
                    completionSubject.send(.selected(location))
                    completionSubject.send(completion: .finished)
                }
                
                
            }
            .store(in: &cancellables)
        
        
        return completionSubject.eraseToAnyPublisher()
    }
    
}
