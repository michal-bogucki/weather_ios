//
//  ListProfilePresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 17/03/2025.
//

import Foundation
import Combine

class ListProfilePresenter: ObservableObject {
    
    enum Output {
        case selectProfile
    }
    
    // Publikujemy zmienną stanu dla widoku
    @Published var currentOutput: Output?
    
    // Strumień dla koordynatora
    let didSelectProfile = PassthroughSubject<Void, Never>()
    
    // Strumień dla kompatybilności z istniejącym kodem
    let output = PassthroughSubject<Output, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        didSelectProfile
            .sink { [weak self] _ in
                print("Profile selected in presenter")
                self?.currentOutput = .selectProfile
                self?.output.send(.selectProfile)
            }
            .store(in: &cancellables)
    }
}
