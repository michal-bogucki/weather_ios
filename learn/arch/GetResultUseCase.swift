//
//  GetResultUseCase.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/03/2025.
//

import Foundation
import Combine

enum DomainResult<T> {
    
    case success(T)
    case error(Error)
}

class GetResultUseCase {
    
//    func execute() -> AnyPublisher<DomainResult<String>, Never> {
//        
//    }
    
    func execute() -> AnyPublisher<String, Never> {
        Just("tapped")
//            .delay(for: 0.1, scheduler: )
            .eraseToAnyPublisher()
    }
}
