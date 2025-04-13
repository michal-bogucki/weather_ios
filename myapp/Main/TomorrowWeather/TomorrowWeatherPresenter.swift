//
//  TomorrowPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 27/03/2025.
//

import Foundation
import Combine
import SwiftUI

class TomorrowWeatherPresenter : ObservableObject {
    
    struct Input {
        let locationSelectedInput: PassthroughSubject<WeatherLocation, Never>
        let locationService: LocationService
    }
    
    enum Output {
        case searchTapped
    }
    

    @Published var selectedLocation: WeatherLocation
    
    lazy var output = makeOutput().share()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    
    private let input: Input
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        input: Input
    ) {
        self.input = input
        self.selectedLocation = input.locationService.currentLocation
        setupBindings()
    }
    
}

private extension TomorrowWeatherPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        didTapSearch
            .map { _ in Output.searchTapped }
            .eraseToAnyPublisher()
    }
    
    func setupBindings() {
        input.locationSelectedInput
            .assign(to: &$selectedLocation)
    }
}
