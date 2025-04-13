//
//  EditProfilePresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 17/03/2025.
//

import Foundation
import Combine

class EditProfilePresenter: ObservableObject {
    
    enum Output {
        case saveCompleted
        case cancel
    }
    
    lazy var output = makeOutput().share()
    
    let didTapSaveChanges = PassthroughSubject<Void, Never>()
    let didTapCancel = PassthroughSubject<Void, Never>()
}

private extension EditProfilePresenter {
    
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapSaveChanges.map { _ in Output.saveCompleted },
            didTapCancel.map { _ in Output.cancel }
        )
        .eraseToAnyPublisher()
    }
}
