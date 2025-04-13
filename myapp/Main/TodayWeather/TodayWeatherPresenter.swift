//
//  TodayWeatherPresenter.swift
//  Weather application_
//
//  Created by Michał Bogucki on 20/03/2025.
//
import Foundation
import Combine

class TodayWeatherPresenter: ObservableObject {
    
    struct Input {
        let locationSelectedInput: PassthroughSubject<WeatherLocation, Never>
        let locationService: LocationService
    }
    
    enum Output {
        case searchTapped
        case showMore
    }
    
    @Published var selectedLocation: WeatherLocation
    @Published var showMore: Bool = false
    
    lazy var output = makeOutput().share() // .first()
    
    let didTapSearch = PassthroughSubject<Void, Never>()
    let didTapShowMore = PassthroughSubject<Void, Never>()
    
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

private extension TodayWeatherPresenter {
    func makeOutput() -> AnyPublisher<Output, Never> {
        Publishers.Merge(
            didTapSearch.map { _ in Output.searchTapped },
            didTapShowMore.map { _ in Output.showMore }
        ).eraseToAnyPublisher()
    }
    
    func setupBindings() {
        input.locationSelectedInput
            .assign(to: &$selectedLocation)

        
        didTapShowMore
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.showMore = !self.showMore
            }
            .store(in: &cancellables)
    }
    
}
