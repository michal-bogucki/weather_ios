//
//  DependencyManager.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import Swinject

class DependencyManager {
    
    static func makeContainer() -> Container {
        let container = Container()
        
        let assemblies = [
            AppAssembly()
        ]
        
        _ = Assembler(assemblies, container: container)
        
        return container
    }
}
