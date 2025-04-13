////
////  WeatherApiModel.swift
////  Weather application_
////
////  Created by Michał Bogucki on 13/04/2025.
////
//
//import Foundation
//
//// MARK: - Główne struktury danych
//
//struct WeatherResponse: Codable {
//    let location: Location
//    let current: CurrentWeather
//    let forecast: Forecast?
//}
//
//struct Location: Codable {
//    let name: String
//    let region: String
//    let country: String
//    let lat: Double
//    let lon: Double
//    let tzId: String
//    let localtimeEpoch: Int
//    let localtime: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name, region, country, lat, lon
//        case tzId = "tz_id"
//        case localtimeEpoch = "localtime_epoch"
//        case localtime
//    }
//}
//
//struct CurrentWeather: Codable {
//    let lastUpdatedEpoch: Int
//    let lastUpdated: String
//    let tempC: Double
//    let tempF: Double
//    let isDay: Int
//    let condition: WeatherCondition
//    let windKph: Double
//    let windDegree: Int
//    let windDir: String
//    let pressureMb: Double
//    let precipMm: Double
//    let humidity: Int
//    let cloud: Int
//    let feelslikeC: Double
//    let feelslikeF: Double
//    let visKm: Double
//    let uv: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case lastUpdatedEpoch = "last_updated_epoch"
//        case lastUpdated = "last_updated"
//        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
//        case condition
//        case windKph = "wind_kph"
//        case windDegree = "wind_degree"
//        case windDir = "wind_dir"
//        case pressureMb = "pressure_mb"
//        case precipMm = "precip_mm"
//        case humidity, cloud
//        case feelslikeC = "feelslike_c"
//        case feelslikeF = "feelslike_f"
//        case visKm = "vis_km"
//        case uv
//    }
//}
//
//struct WeatherCondition: Codable {
//    let text: String
//    let icon: String
//    let code: Int
//}
//
//struct Forecast: Codable {
//    let forecastday: [ForecastDay]
//}
//
//struct ForecastDay: Codable {
//    let date: String
//    let dateEpoch: Int
//    let day: Day
//    let astro: Astro
//    let hour: [Hour]?
//    
//    enum CodingKeys: String, CodingKey {
//        case date
//        case dateEpoch = "date_epoch"
//        case day, astro, hour
//    }
//}
//
//struct Day: Codable {
//    let maxtempC: Double
//    let maxtempF: Double
//    let mintempC: Double
//    let mintempF: Double
//    let avgtempC: Double
//    let avgtempF: Double
//    let maxwindKph: Double
//    let maxwindMph: Double
//    let totalprecipMm: Double
//    let totalprecipIn: Double
//    let totalsnowCm: Double
//    let avgvisKm: Double
//    let avgvisMiles: Double
//    let avghumidity: Double
//    let dailyWillItRain: Int
//    let dailyChanceOfRain: Int
//    let dailyWillItSnow: Int
//    let dailyChanceOfSnow: Int
//    let condition: WeatherCondition
//    let uv: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case maxtempC = "maxtemp_c"
//        case maxtempF = "maxtemp_f"
//        case mintempC = "mintemp_c"
//        case mintempF = "mintemp_f"
//        case avgtempC = "avgtemp_c"
//        case avgtempF = "avgtemp_f"
//        case maxwindKph = "maxwind_kph"
//        case maxwindMph = "maxwind_mph"
//        case totalprecipMm = "totalprecip_mm"
//        case totalprecipIn = "totalprecip_in"
//        case totalsnowCm = "totalsnow_cm"
//        case avgvisKm = "avgvis_km"
//        case avgvisMiles = "avgvis_miles"
//        case avghumidity
//        case dailyWillItRain = "daily_will_it_rain"
//        case dailyChanceOfRain = "daily_chance_of_rain"
//        case dailyWillItSnow = "daily_will_it_snow"
//        case dailyChanceOfSnow = "daily_chance_of_snow"
//        case condition, uv
//    }
//}
//
//struct Astro: Codable {
//    let sunrise: String
//    let sunset: String
//    let moonrise: String
//    let moonset: String
//    let moonPhase: String
//    let moonIllumination: String
//    
//    enum CodingKeys: String, CodingKey {
//        case sunrise, sunset, moonrise, moonset
//        case moonPhase = "moon_phase"
//        case moonIllumination = "moon_illumination"
//    }
//}
//
//struct Hour: Codable {
//    let timeEpoch: Int
//    let time: String
//    let tempC: Double
//    let tempF: Double
//    let isDay: Int
//    let condition: WeatherCondition
//    let windKph: Double
//    let windDegree: Int
//    let windDir: String
//    let pressureMb: Double
//    let precipMm: Double
//    let humidity: Int
//    let cloud: Int
//    let feelslikeC: Double
//    let feelslikeF: Double
//    let windchillC: Double
//    let windchillF: Double
//    let heatindexC: Double
//    let heatindexF: Double
//    let dewpointC: Double
//    let dewpointF: Double
//    let willItRain: Int
//    let chanceOfRain: Int
//    let willItSnow: Int
//    let chanceOfSnow: Int
//    let visKm: Double
//    let visMiles: Double
//    let gustKph: Double
//    let gustMph: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case timeEpoch = "time_epoch"
//        case time
//        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
//        case condition
//        case windKph = "wind_kph"
//        case windDegree = "wind_degree"
//        case windDir = "wind_dir"
//        case pressureMb = "pressure_mb"
//        case precipMm = "precip_mm"
//        case humidity, cloud
//        case feelslikeC = "feelslike_c"
//        case feelslikeF = "feelslike_f"
//        case windchillC = "windchill_c"
//        case windchillF = "windchill_f"
//        case heatindexC = "heatindex_c"
//        case heatindexF = "heatindex_f"
//        case dewpointC = "dewpoint_c"
//        case dewpointF = "dewpoint_f"
//        case willItRain = "will_it_rain"
//        case chanceOfRain = "chance_of_rain"
//        case willItSnow = "will_it_snow"
//        case chanceOfSnow = "chance_of_snow"
//        case visKm = "vis_km"
//        case visMiles = "vis_miles"
//        case gustKph = "gust_kph"
//        case gustMph = "gust_mph"
//    }
//}
