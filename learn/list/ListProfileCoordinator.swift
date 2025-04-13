//
//  ListProfileCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 17/03/2025.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import Swinject

class ListProfileCoordinator {
    
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = [AnyCancellable]()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.tabBarItem.title = "List Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
        
        let listProfilePresenter = resolver.resolve(ListProfilePresenter.self)!
        let listProfile = ListProfileScreen(presenter: listProfilePresenter)
        let listProfileVC = CustomHostingController(rootView: listProfile)
        listProfileVC.title = "List Profile"
        
        // Subscribe to presenter output
        listProfilePresenter.didSelectProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                print("Profile selected in ListProfileCoordinator")
                // Handle navigation or other actions when a profile is selected
            }
            .store(in: &cancellables)
        
        navigationController.viewControllers = [listProfileVC]
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}
