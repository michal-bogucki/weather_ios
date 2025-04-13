//
//  SearchPresentCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 31/03/2025.
//

import UIKit
import Swinject
import Combine

class SearchPresentCoordinator {
    
    struct Input {
        let viewController: UIViewController
    }
    
    enum Output {
        case close
    }
    
    private let input: Input
    private let resolver: Resolver
    
    init(
        resolver: Resolver,
        input: Input
    ) {
        self.resolver = resolver
        self.input = input
    }
    
    func start() -> AnyPublisher<Output, Never> {
        let searchPresenter = resolver.resolve(SearchPresenter.self)!
        let searchScreen = SearchContainer(presenter: searchPresenter)
        let searchVC = CustomHostingController(rootView: searchScreen)
        searchVC.hidesBottomBarWhenPushed = true
                
        input.viewController.present(searchVC, animated: true)
        
        return searchPresenter
            .output
            .map { _ in Output.close }
            .flatMap { output in
                Future { promise in
                    searchVC.dismiss(animated: true) {
                        promise(.success(output))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
