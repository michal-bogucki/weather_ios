//
//  ProfileCoordinator.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import Swinject

class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    private let resolver: Resolver
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() -> AnyPublisher<Void, Never> {
        navigationController.tabBarItem.title = "Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        
        let profilePresenter = resolver.resolve(ProfilePresenter.self)!
        let profile = ProfileScreen(presenter: profilePresenter)
        let profileVC = CustomHostingController(rootView: profile)
        profileVC.title = "Profile"
        
        navigationController.viewControllers = [profileVC]
        
        profilePresenter.output
            .sink { output in
                switch output {
                case .editProfile:
                    self.showEditProfile()
                }
            }
            .store(in: &cancellables)
        
        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
    
    private func showEditProfile() {
        
    }
}
