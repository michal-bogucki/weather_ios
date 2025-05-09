import SwiftUI
import Foundation

// MARK: - Modele widoku

/// Model reprezentujący lokalizację dla ekranu głównego
struct WeatherLocation {
    let id: Int
    let name: String
    let region: String
    let country: String
    let date: String
    let temp: Int
    let feels: Int
    let high: Int
    let low: Int
    let wind: Int
    let humidity: Int
    let sunrise: String
    let sunset: String
    let pressure: Int
    let uvIndex: String
    let visibility: Int
    let windDirection: String
    let airQuality: String
    let moonPhase: String
    let precipitation: Int
    let condition: WeatherConditionIcon
    let weeklyForecast: [DailyForecast]
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String             // Nazwę dnia, np. "Poniedziałek"
    let date: String            // Datę, np. "13 kwietnia"
    let high: Int               // Najwyższa temperatura dnia
    let low: Int                // Najniższa temperatura dnia
    let condition: WeatherConditionIcon  // Warunki pogodowe
    let precipitation: Int      // Prawdopodobieństwo opadów (%)
    let wind: Int               // Prędkość wiatru (km/h)
    let uvIndex: Int            // Indeks UV
    let humidity: Int           // Wilgotność (%)
    let sunrise: String         // Czas wschodu słońca
    let sunset: String          // Czas zachodu słońca
    let pressure: Int           // Ciśnienie atmosferyczne (hPa)
    let visibility: Int         // Widoczność (km)
}

class WeatherViewModelMapper {
    
    static func mapToDailyForecasts(from response: WeatherResponse) -> [DailyForecast] {
            guard let forecastDays = response.forecast?.forecastday else {
                return []
            }
            
            return forecastDays.map { forecastDay in
                // Format daty
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "pl_PL")
                
                // Format nazwy dnia
                dateFormatter.dateFormat = "EEEE"
                let date = Date(timeIntervalSince1970: TimeInterval(forecastDay.dateEpoch))
                let dayName = dateFormatter.string(from: date)
                
                // Format daty
                dateFormatter.dateFormat = "d MMMM"
                let dateString = dateFormatter.string(from: date)
                
                // Warunki pogodowe
                let conditionIcon = WeatherConditionIcon.fromCode(forecastDay.day.condition.code, isDay: true)
                
                return DailyForecast(
                    day: dayName,
                    date: dateString,
                    high: Int(forecastDay.day.maxtempC.rounded()),
                    low: Int(forecastDay.day.mintempC.rounded()),
                    condition: conditionIcon,
                    precipitation: forecastDay.day.dailyChanceOfRain,
                    wind: Int(forecastDay.day.maxwindKph.rounded()),
                    uvIndex: Int(forecastDay.day.uv.rounded()),
                    humidity: Int(forecastDay.day.avghumidity.rounded()),
                    sunrise: forecastDay.astro.sunrise,
                    sunset: forecastDay.astro.sunset,
                    pressure: 1015, // Wartość domyślna, ponieważ API nie zawiera tego w prognozie dziennej
                    visibility: Int(forecastDay.day.avgvisKm.rounded())
                )
            }
        }
    
    /// Mapuje odpowiedź z API na model lokalizacji
    static func mapToLocation(from response: WeatherResponse) -> WeatherLocation {
        // Format daty
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pl_PL")
        dateFormatter.dateFormat = "EEEE, d MMMM"
        
        let date = Date(timeIntervalSince1970: TimeInterval(response.location.localtimeEpoch))
        let formattedDate = dateFormatter.string(from: date)
        
        // Warunki pogodowe
        let conditionIcon = WeatherConditionIcon.fromCode(response.current.condition.code, isDay: response.current.isDay == 1)
        
        // Wartości domyślne dla danych, które mogą nie być dostępne w niektórych API
        let forecastDay = response.forecast?.forecastday.first
        
        // Wartości dla wschodu/zachodu słońca
        let sunrise = forecastDay?.astro.sunrise ?? "06:00"
        let sunset = forecastDay?.astro.sunset ?? "18:00"
        let moonPhase = forecastDay?.astro.moonPhase ?? "Waxing Crescent"
        
        // Obliczenie prawdopodobieństwa opadów
        let precipitation = forecastDay?.day.dailyChanceOfRain ?? 0
        
        return WeatherLocation(
            id: 123,
            name: response.location.name,
            region: response.location.region,
            country: response.location.country,
            date: formattedDate,
            temp: Int(response.current.tempC.rounded()),
            feels: Int(response.current.feelslikeC.rounded()),
            high: Int((forecastDay?.day.maxtempC ?? response.current.tempC + 2).rounded()),
            low: Int((forecastDay?.day.mintempC ?? response.current.tempC - 2).rounded()),
            wind: Int(response.current.windKph.rounded()),
            humidity: response.current.humidity,
            sunrise: sunrise,
            sunset: sunset,
            pressure: Int(response.current.pressureMb.rounded()),
            uvIndex: String(format: "%.1f", response.current.uv),
            visibility: Int(response.current.visKm.rounded()),
            windDirection: response.current.windDir,
            airQuality: "Dobra", // Domyślna wartość, jeśli nie ma w API
            moonPhase: moonPhase,
            precipitation: precipitation,
            condition: conditionIcon,
            weeklyForecast: mapToDailyForecasts(from: response)
        )
    }
}
