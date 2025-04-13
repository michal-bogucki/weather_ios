//
//  HomeCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import Combine
import Swinject
import SwiftUI
import UIKit

class HomeCoordinator {
    private let resolver: Resolver
    private let window: UIWindow
    private var cancellables = [AnyCancellable]()
    
    init(resolver: Resolver, window: UIWindow) {
        self.resolver = resolver
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let profile = makeProfile()
        let listProfile = makeListProfile()
        
        tabBarController.setViewControllers([listProfile, profile], animated: false)
        
        window.rootViewController = tabBarController
    }
}

private extension HomeCoordinator {
    
    func makeProfile() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let profileCoordinator = resolver.resolve(
            ProfileCoordinator.self,
            argument: navigationController
        )!
        
        profileCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
    
    func makeListProfile() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let listProfileCoordinator = resolver.resolve(
            ListProfileCoordinator.self,
            argument: navigationController
        )!
        
        listProfileCoordinator
            .start()
            .sink { _ in }
            .store(in: &cancellables)
        
        return navigationController
    }
}
