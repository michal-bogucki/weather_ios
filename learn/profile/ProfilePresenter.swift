//
//  ProfilePresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/03/2025.
//

import Foundation
import Combine

class ProfilePresenter: ObservableObject {
    
    enum Output {
        case editProfile
    }
    
    @Published var currentOutput: Output?
    
    lazy var output = makeOutput().share()

    let didTapEditProfile = PassthroughSubject<Void, Never>()
    
    
    private var cancellables = Set<AnyCancellable>()
    
}

private extension ProfilePresenter {
    
    func makeOutput() -> AnyPublisher<Output, Never> {
        didTapEditProfile
            .map { _ in .editProfile }
            .eraseToAnyPublisher()
    }
}
