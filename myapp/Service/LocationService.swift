//
//  LocationService.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/04/2025.
//

import Combine
import Foundation

class LocationService {
    static let shared = LocationService()
    
    let locationSelected = PassthroughSubject<WeatherLocation, Never>()
    @Published var currentLocation: WeatherLocation
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        self.currentLocation = sampleData[0]
        locationSelected
            .sink { [weak self] location in
                self?.currentLocation = location
                NotificationCenter.default.post(
                    name: NSNotification.Name("weatherLocationChanged"),
                    object: location
                )
            }
            .store(in: &cancellables)
    }
}
