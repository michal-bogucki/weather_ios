//
//  DetailsPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 11/04/2025.
//
import Combine
import SwiftUI

class DetailsPresenter : ObservableObject {
    
    struct Input {
        let locationSelectedInput: PassthroughSubject<DailyForecast, Never>
        let locationService: LocationService
    }
    
    enum Output {
        case backToMain
    }
    
    @Published var selectedLocation: DailyForecast
    
    lazy var output = makeOutput().share()
    
    private let input: Input
    
    let didTapBack = PassthroughSubject<Void, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        input: Input
    ) {
        self.input = input
        self.selectedLocation = input.locationService.currentDaily
        setupBindings()
    }
}

private extension DetailsPresenter {
    func setupBindings() {
        input.locationSelectedInput
            .assign(to: &$selectedLocation)
    }
    
    func makeOutput() -> AnyPublisher<Output, Never> {
        didTapBack.map { _ in Output.backToMain }
        .eraseToAnyPublisher()
    }
}
