//
//  SearchPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 27/03/2025.
//
import Combine
import SwiftUI

class SearchPresenter : ObservableObject {
    enum Output {
        case backToMain
        case citySearch(WeatherLocation)
    }
    

    @Published var recentLocations: [WeatherLocation]
    @Published var searchText: String = ""
    
    lazy var output = makeOutput().share()
    
    let didTapBack = PassthroughSubject<Void, Never>()
    let didSelectCity = PassthroughSubject<WeatherLocation, Never>()
    
    init() {
        self.recentLocations = sampleData
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
