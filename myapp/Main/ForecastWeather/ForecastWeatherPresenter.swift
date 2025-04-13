//
//  ForecastWeatherPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 08/04/2025.
//

import Foundation
import Combine

class ForecastWeatherPresenter: ObservableObject {
    struct Input {
        let locationSelectedInput: PassthroughSubject<WeatherLocation, Never>
        let locationService: LocationService
    }
    
    enum Output {
        case searchTapped
        case openDetails(WeatherLocation)
    }
    
    @Published var selectedLocation: WeatherLocation
    
    lazy var output = makeOutput().share()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    let didTapOpenDetails = PassthroughSubject<WeatherLocation, Never>()
    
    private let input: Input
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        input: Input
    ) {
        self.input = input
        self.selectedLocation = input.locationService.currentLocation
        setupBindings()
    }
}

private extension ForecastWeatherPresenter {
    func setupBindings() {
        input.locationSelectedInput
            .assign(to: &$selectedLocation)
    }
    
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapSearch.map { _ in Output.searchTapped },
            didTapOpenDetails.map { lock in Output.openDetails(lock) }
        )
        .eraseToAnyPublisher()
    }
}
