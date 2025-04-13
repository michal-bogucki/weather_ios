////
////  WeatherApiModelMapper.swift
////  Weather application_
////
////  Created by Michał Bogucki on 13/04/2025.
////
//
//import Foundation
//import SwiftUI
//import Combine
//
//// MARK: - Modele danych aplikacji
//
//// Pomocnicza struktura dla lokalizacji używana w widokach wyszukiwania
//struct WeatherLocation: Identifiable {
//    let id = UUID()
//    let name: String        // Nazwa miasta
//    let country: String     // Nazwa kraju
//    let region: String      // Region
//    let date: String        // Aktualna data
//    let temp: Int           // Aktualna temperatura
//    let high: Int           // Maksymalna temperatura dnia
//    let low: Int            // Minimalna temperatura dnia
//    let condition: WeatherConditionIcon
//    let precipitation: Int  // Prawdopodobieństwo opadów
//    let wind: Int           // Prędkość wiatru
//    let humidity: Int       // Wilgotność
//    let uvIndex: Int        // Indeks UV
//    let weeklyForecast: [WeekDay] // Prognoza tygodniowa
//}
//
//// Model dnia tygodnia używany w widoku prognozy
//struct WeekDay: Identifiable {
//    let id = UUID()
//    let day: String         // Nazwa dnia np. "Poniedziałek"
//    let date: String        // Data w formacie "15 Kwi"
//    let high: Int           // Maksymalna temperatura
//    let low: Int            // Minimalna temperatura
//    let condition: WeatherConditionIcon
//    let precipitation: Int  // Prawdopodobieństwo opadów
//    let wind: Int           // Prędkość wiatru
//    let humidity: Int       // Wilgotność
//    let uvIndex: Int        // Indeks UV
//}
//
//// MARK: - Mapper
//
//class WeatherDataMapper {
//    
//    // Metoda mapująca kod warunku pogodowego z API na WeatherConditionIcon
//    static func mapToWeatherConditionIcon(_ code: Int, isDay: Bool = true) -> WeatherConditionIcon {
//        return WeatherConditionIcon.fromCode(code, isDay: isDay)
//    }
//    
//    // Metoda formatująca datę z API na format wyświetlany w aplikacji
//    static func formatDate(_ dateString: String) -> String {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//        
//        guard let date = inputFormatter.date(from: dateString) else {
//            return dateString
//        }
//        
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateFormat = "d MMMM yyyy"
//        outputFormatter.locale = Locale(identifier: "pl_PL")
//        
//        return outputFormatter.string(from: date)
//    }
//    
//    // Metoda formatująca datę do nazwy dnia tygodnia
//    static func formatToDayName(_ dateString: String) -> String {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//        
//        guard let date = inputFormatter.date(from: dateString) else {
//            return dateString
//        }
//        
//        let dayFormatter = DateFormatter()
//        dayFormatter.dateFormat = "EEEE"
//        dayFormatter.locale = Locale(identifier: "pl_PL")
//        
//        return dayFormatter.string(from: date).capitalized
//    }
//    
//    // Metoda formatująca datę do krótkiego formatu (15 Kwi)
//    static func formatToShortDate(_ dateString: String) -> String {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//        
//        guard let date = inputFormatter.date(from: dateString) else {
//            return dateString
//        }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMM"
//        dateFormatter.locale = Locale(identifier: "pl_PL")
//        
//        return dateFormatter.string(from: date)
//    }
//    
//    // Metoda mapująca dzień prognozy na model WeekDay
//    static func mapToWeekDay(_ forecastDay: ForecastDay) -> WeekDay {
//        let condition = mapToWeatherConditionIcon(forecastDay.day.condition.code)
//        
//        return WeekDay(
//            day: formatToDayName(forecastDay.date),
//            date: formatToShortDate(forecastDay.date),
//            high: Int(forecastDay.day.maxtempC.rounded()),
//            low: Int(forecastDay.day.mintempC.rounded()),
//            condition: condition,
//            precipitation: forecastDay.day.dailyChanceOfRain,
//            wind: Int(forecastDay.day.maxwindKph.rounded()),
//            humidity: Int(forecastDay.day.avghumidity.rounded()),
//            uvIndex: Int(forecastDay.day.uv.rounded())
//        )
//    }
//    
//    // Metoda główna mapująca pełną odpowiedź z API na model aplikacji
//    static func mapToWeatherLocation(_ response: WeatherResponse) -> WeatherLocation {
//        let currentWeather = response.current
//        let location = response.location
//        
//        // Mapowanie aktualnych warunków pogodowych
//        let condition = mapToWeatherConditionIcon(currentWeather.condition.code, isDay: currentWeather.isDay == 1)
//        
//        // Formatowanie daty z czasu lokalnego
//        let formattedDate = formatDate(location.localtime.prefix(10).description)
//        
//        // Mapowanie prognozy tygodniowej
//        var weeklyForecast: [WeekDay] = []
//        if let forecast = response.forecast {
//            weeklyForecast = forecast.forecastday.map { forecastDay in
//                mapToWeekDay(forecastDay)
//            }
//        }
//        
//        // Pobieranie informacji o temperaturach z dzisiejszej prognozy
//        let today = response.forecast?.forecastday.first
//        let high = today?.day.maxtempC.rounded() ?? (currentWeather.tempC + 3).rounded()
//        let low = today?.day.mintempC.rounded() ?? (currentWeather.tempC - 3).rounded()
//        
//        // Tworzenie obiektu lokalizacji
//        return WeatherLocation(
//            name: location.name,
//            country: location.country,
//            region: location.region,
//            date: formattedDate,
//            temp: Int(currentWeather.tempC.rounded()),
//            high: Int(high),
//            low: Int(low),
//            condition: condition,
//            precipitation: today?.day.dailyChanceOfRain ?? 0,
//            wind: Int(currentWeather.windKph.rounded()),
//            humidity: currentWeather.humidity,
//            uvIndex: Int(currentWeather.uv.rounded()),
//            weeklyForecast: weeklyForecast
//        )
//    }
//    
//    // Mapowanie do lokalizacji dla pogody na jutro (używane przez TomorrowWeatherPresenter)
//    static func mapToTomorrowWeatherLocation(_ response: WeatherResponse) -> WeatherLocation? {
//        guard let forecast = response.forecast,
//              forecast.forecastday.count >= 2 else {
//            return nil
//        }
//        
//        let tomorrowForecast = forecast.forecastday[1]
//        let location = response.location
//        
//        // Mapowanie warunków pogodowych na jutro
//        let condition = mapToWeatherConditionIcon(tomorrowForecast.day.condition.code)
//        
//        // Formatowanie daty jutra
//        let formattedDate = formatDate(tomorrowForecast.date)
//        
//        // Tworzenie obiektu lokalizacji dla jutra
//        return WeatherLocation(
//            name: location.name,
//            country: location.country,
//            region: location.region,
//            date: formattedDate,
//            temp: Int(tomorrowForecast.day.avgtempC.rounded()),
//            high: Int(tomorrowForecast.day.maxtempC.rounded()),
//            low: Int(tomorrowForecast.day.mintempC.rounded()),
//            condition: condition,
//            precipitation: tomorrowForecast.day.dailyChanceOfRain,
//            wind: Int(tomorrowForecast.day.maxwindKph.rounded()),
//            humidity: Int(tomorrowForecast.day.avghumidity.rounded()),
//            uvIndex: Int(tomorrowForecast.day.uv.rounded()),
//            weeklyForecast: [mapToWeekDay(tomorrowForecast)] // Zawiera tylko jutrzejszy dzień w prognozie
//        )
//    }
//    
//    // Metoda mapująca dane do listy lokalizacji dla ekranu wyszukiwania
//    static func mapToSearchResults(_ responses: [WeatherResponse]) -> [WeatherLocation] {
//        return responses.map { mapToWeatherLocation($0) }
//    }
//}
