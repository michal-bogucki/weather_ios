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
    
    let dailyForecastSelected = PassthroughSubject<DailyForecast, Never>()
    
    @Published var currentLocation: WeatherLocation
    
    @Published var currentDaily: DailyForecast
    
    let sampleWeather: [WeatherLocation] = sampleData
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        self.currentLocation = sampleWeather[0]
        self.currentDaily = sampleWeather[0].weeklyForecast[1]
        locationSelected
            .sink { [weak self] location in
                self?.currentLocation = location
                NotificationCenter.default.post(
                    name: NSNotification.Name("weatherLocationChanged"),
                    object: location
                )
            }
            .store(in: &cancellables)
        
        dailyForecastSelected
            .sink { [weak self] dailyForecast in
                self?.currentDaily = dailyForecast
            }
            .store(in: &cancellables)
    }
}
