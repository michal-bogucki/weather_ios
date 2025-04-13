//
//  HomePresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/03/2025.

import Foundation
import Combine

class HomePresenter: ObservableObject {
    
    @Published var text: String = ""
    @Published var isLoading: Bool = false
    
    let didTapButton = PassthroughSubject<Void, Never>()
    
    lazy var result = makeResult().share()
    
    private let getResultUseCase: GetResultUseCase
    
//    private var cancellables = [AnyCancellable]()
    
    init(getResultUseCase: GetResultUseCase) {
        self.getResultUseCase = getResultUseCase
        
       // bindButtons()
        bindState()
    }
}

private extension HomePresenter {
    
    func makeResult() -> AnyPublisher<String, Never> {
        didTapButton
            .flatMap { [getResultUseCase] _ in
                getResultUseCase.execute()
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Buttons

private extension HomePresenter {
    
//    func bindButtons() {
////        didTapButton
////            .sink { [weak self] _ in
////                guard let self else {
////                    return
////                }
////                
////                self.text = "tapped"
////            }
////            .store(in: &cancellables)
//        
////        didTapButton
////            .flatMap { [getResultUseCase] _ in
////                getResultUseCase.execute()
////            }
////            .assign(to: &$text)
//    }
//    
    func bindState() {
        Publishers.Merge(
            didTapButton
                .map { _ in true },
            result
                .map { _ in false }
        )
        .assign(to: &$isLoading)
    }
}
