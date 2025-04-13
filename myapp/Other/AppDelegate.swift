//
//  AppDelegate.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/03/2025.
//

import UIKit
import SwiftUI
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let container = DependencyManager.makeContainer()

    lazy var appCoordinator = container.resolve(WeatherAppCoordinator.self)!
    
    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        appCoordinator.start()
        
        return true
    }

}

