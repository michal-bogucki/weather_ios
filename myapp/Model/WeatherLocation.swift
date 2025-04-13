//import SwiftUI
//import CoreLocation
//
//// MARK: - Data Models
//
//struct WeatherLocation: Identifiable {
//    let id: Int
//    let name: String
//    let country: String
//    let date: String
//    let temp: Int
//    let feels: Int
//    let condition: WeatherConditionIcon
//    let high: Int
//    let low: Int
//    let humidity: Int
//    let wind: Int
//    let windDirection: String
//    let pressure: Int
//    let uvIndex: Int
//    let visibility: Double
//    let airQuality: String
//    let sunrise: String
//    let sunset: String
//    let moonPhase: String
//    let precipitation: Int
//    let weeklyForecast: [DailyForecast]
//}
//
//struct DailyForecast: Identifiable {
//    let id = UUID()
//    let day: String
//    let high: Int
//    let low: Int
//    let condition: WeatherConditionIcon
//}
//
//// Weather condition from the provided JSON
//struct WeatherConditionData: Identifiable, Codable {
//    var id = UUID()
//    let code: Int
//    let day: String
//    let night: String
//    let icon: Int
//}
//
//// MARK: - Sample Data
//let sampleData: [WeatherLocation] = [
//    WeatherLocation(
//        id: 1,
//        name: "Tokyo",
//        country: "Japan",
//        date: "wednesday, 18 nov",
//        temp: 19,
//        feels: 17,
//        condition: .sunny, // Code 1000 day
//        high: 21,
//        low: 15,
//        humidity: 65,
//        wind: 12,
//        windDirection: "NE",
//        pressure: 1013,
//        uvIndex: 5,
//        visibility: 9.7,
//        airQuality: "Good",
//        sunrise: "06:42",
//        sunset: "17:21",
//        moonPhase: "Waxing Crescent",
//        precipitation: 0,
//        weeklyForecast: [
//            DailyForecast(day: "Wed", high: 21, low: 15, condition: .sunny),
//            DailyForecast(day: "Thu", high: 22, low: 16, condition: .partlyCloudy),
//            DailyForecast(day: "Fri", high: 20, low: 15, condition: .cloudy),
//            DailyForecast(day: "Sat", high: 19, low: 14, condition: .lightRain),
//            DailyForecast(day: "Sun", high: 18, low: 13, condition: .moderateRain),
//            DailyForecast(day: "Mon", high: 20, low: 14, condition: .partlyCloudy)
//        ]
//    ),
//    WeatherLocation(
//        id: 2,
//        name: "New York",
//        country: "USA",
//        date: "thursday, 19 nov",
//        temp: 12,
//        feels: 9,
//        condition: .moderateRain, // Code 1189
//        high: 14,
//        low: 8,
//        humidity: 78,
//        wind: 15,
//        windDirection: "SW",
//        pressure: 1008,
//        uvIndex: 2,
//        visibility: 4.5,
//        airQuality: "Moderate",
//        sunrise: "06:52",
//        sunset: "16:45",
//        moonPhase: "First Quarter",
//        precipitation: 80,
//        weeklyForecast: [
//            DailyForecast(day: "Thu", high: 14, low: 8, condition: .moderateRain),
//            DailyForecast(day: "Fri", high: 13, low: 7, condition: .lightRain),
//            DailyForecast(day: "Sat", high: 12, low: 6, condition: .cloudy),
//            DailyForecast(day: "Sun", high: 14, low: 9, condition: .partlyCloudy),
//            DailyForecast(day: "Mon", high: 15, low: 10, condition: .sunny),
//            DailyForecast(day: "Tue", high: 15, low: 11, condition: .sunny)
//        ]
//    ),
//    WeatherLocation(
//        id: 3,
//        name: "London",
//        country: "UK",
//        date: "thursday, 19 nov",
//        temp: 10,
//        feels: 7,
//        condition: .thunderyOutbreaksPossible, // Code 1087
//        high: 12,
//        low: 6,
//        humidity: 82,
//        wind: 18,
//        windDirection: "W",
//        pressure: 1002,
//        uvIndex: 1,
//        visibility: 3.5,
//        airQuality: "Poor",
//        sunrise: "07:21",
//        sunset: "16:15",
//        moonPhase: "Waning Gibbous",
//        precipitation: 90,
//        weeklyForecast: [
//            DailyForecast(day: "Thu", high: 12, low: 6, condition: .moderateOrHeavyRainWithThunder),
//            DailyForecast(day: "Fri", high: 11, low: 5, condition: .moderateRain),
//            DailyForecast(day: "Sat", high: 10, low: 5, condition: .lightRain),
//            DailyForecast(day: "Sun", high: 9, low: 4, condition: .cloudy),
//            DailyForecast(day: "Mon", high: 10, low: 6, condition: .partlyCloudy),
//            DailyForecast(day: "Tue", high: 12, low: 7, condition: .partlyCloudy)
//        ]
//    )
//]
