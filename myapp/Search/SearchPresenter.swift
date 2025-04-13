//
//  SearchPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 27/03/2025.
//
import Combine
import SwiftUI

class SearchPresenter : ObservableObject {
    
    struct Input {
        let locationService: LocationService
    }
    
    enum Output {
        case backToMain
        case citySearch(WeatherLocation)
    }
    

    @Published var recentLocations: [WeatherLocation]
    @Published var searchText: String = ""
    private let input: Input
    lazy var output = makeOutput().share()
    
    let didTapBack = PassthroughSubject<Void, Never>()
    let didSelectCity = PassthroughSubject<WeatherLocation, Never>()
    
    init(
        input: Input
    ) {
        self.input = input
        self.recentLocations = input.locationService.sampleWeather
    }
    
}

private extension SearchPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapBack
                .map{_ in Output.backToMain},
            didSelectCity
                .map{ lock in Output.citySearch(lock) }

        )
        .eraseToAnyPublisher()
    }
    
}
