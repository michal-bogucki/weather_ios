//
//  WeatherCondition.swift
//  Weather application_
//
//  Created by Michał Bogucki on 02/04/2025.
//

import SwiftUI

// MARK: - Weather Condition Enum with all codes from JSON

enum WeatherConditionIcon: Equatable {
    // Clear / Sunny
    case clear // 1000 night
    case sunny // 1000 day
    
    // Cloudy variations
    case partlyCloudy // 1003
    case cloudy // 1006
    case overcast // 1009
    
    // Mist and fog
    case mist // 1030
    case fog // 1135
    case freezingFog // 1147
    
    // Rain variations
    case patchyRainPossible // 1063
    case patchyLightDrizzle // 1150
    case lightDrizzle // 1153
    case freezingDrizzle // 1168
    case heavyFreezingDrizzle // 1171
    case patchyLightRain // 1180
    case lightRain // 1183
    case moderateRainAtTimes // 1186
    case moderateRain // 1189
    case heavyRainAtTimes // 1192
    case heavyRain // 1195
    case lightFreezingRain // 1198
    case moderateOrHeavyFreezingRain // 1201
    case lightRainShower // 1240
    case moderateOrHeavyRainShower // 1243
    case torrentialRainShower // 1246
    
    // Snow variations
    case patchySnowPossible // 1066
    case patchySleetPossible // 1069
    case patchyFreezingDrizzlePossible // 1072
    case blowingSnow // 1114
    case blizzard // 1117
    case lightSleet // 1204
    case moderateOrHeavySleet // 1207
    case patchyLightSnow // 1210
    case lightSnow // 1213
    case patchyModerateSnow // 1216
    case moderateSnow // 1219
    case patchyHeavySnow // 1222
    case heavySnow // 1225
    case icePellets // 1237
    case lightSleetShowers // 1249
    case moderateOrHeavySleetShowers // 1252
    case lightSnowShowers // 1255
    case moderateOrHeavySnowShowers // 1258
    case lightShowersOfIcePellets // 1261
    case moderateOrHeavyShowersOfIcePellets // 1264
    
    // Thunder variations
    case thunderyOutbreaksPossible // 1087
    case patchyLightRainWithThunder // 1273
    case moderateOrHeavyRainWithThunder // 1276
    case patchyLightSnowWithThunder // 1279
    case moderateOrHeavySnowWithThunder // 1282
    
    // Factory method to create from code
    static func fromCode(_ code: Int, isDay: Bool = true) -> WeatherConditionIcon {
        switch code {
        case 1000:
            return isDay ? .sunny : .clear
        case 1003:
            return .partlyCloudy
        case 1006:
            return .cloudy
        case 1009:
            return .overcast
        case 1030:
            return .mist
        case 1063:
            return .patchyRainPossible
        case 1066:
            return .patchySnowPossible
        case 1069:
            return .patchySleetPossible
        case 1072:
            return .patchyFreezingDrizzlePossible
        case 1087:
            return .thunderyOutbreaksPossible
        case 1114:
            return .blowingSnow
        case 1117:
            return .blizzard
        case 1135:
            return .fog
        case 1147:
            return .freezingFog
        case 1150:
            return .patchyLightDrizzle
        case 1153:
            return .lightDrizzle
        case 1168:
            return .freezingDrizzle
        case 1171:
            return .heavyFreezingDrizzle
        case 1180:
            return .patchyLightRain
        case 1183:
            return .lightRain
        case 1186:
            return .moderateRainAtTimes
        case 1189:
            return .moderateRain
        case 1192:
            return .heavyRainAtTimes
        case 1195:
            return .heavyRain
        case 1198:
            return .lightFreezingRain
        case 1201:
            return .moderateOrHeavyFreezingRain
        case 1204:
            return .lightSleet
        case 1207:
            return .moderateOrHeavySleet
        case 1210:
            return .patchyLightSnow
        case 1213:
            return .lightSnow
        case 1216:
            return .patchyModerateSnow
        case 1219:
            return .moderateSnow
        case 1222:
            return .patchyHeavySnow
        case 1225:
            return .heavySnow
        case 1237:
            return .icePellets
        case 1240:
            return .lightRainShower
        case 1243:
            return .moderateOrHeavyRainShower
        case 1246:
            return .torrentialRainShower
        case 1249:
            return .lightSleetShowers
        case 1252:
            return .moderateOrHeavySleetShowers
        case 1255:
            return .lightSnowShowers
        case 1258:
            return .moderateOrHeavySnowShowers
        case 1261:
            return .lightShowersOfIcePellets
        case 1264:
            return .moderateOrHeavyShowersOfIcePellets
        case 1273:
            return .patchyLightRainWithThunder
        case 1276:
            return .moderateOrHeavyRainWithThunder
        case 1279:
            return .patchyLightSnowWithThunder
        case 1282:
            return .moderateOrHeavySnowWithThunder
        default:
            return isDay ? .sunny : .clear // Default fallback
        }
    }
    
    // Get display name based on the condition
    var displayName: String {
        switch self {
        case .clear: return "Clear"
        case .sunny: return "Sunny"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .overcast: return "Overcast"
        case .mist: return "Mist"
        case .fog: return "Fog"
        case .freezingFog: return "Freezing Fog"
        case .patchyRainPossible: return "Patchy Rain"
        case .patchyLightDrizzle: return "Light Drizzle"
        case .lightDrizzle: return "Light Drizzle"
        case .freezingDrizzle: return "Freezing Drizzle"
        case .heavyFreezingDrizzle: return "Heavy Freezing Drizzle"
        case .patchyLightRain: return "Light Rain"
        case .lightRain: return "Light Rain"
        case .moderateRainAtTimes: return "Moderate Rain"
        case .moderateRain: return "Moderate Rain"
        case .heavyRainAtTimes: return "Heavy Rain"
        case .heavyRain: return "Heavy Rain"
        case .lightFreezingRain: return "Light Freezing Rain"
        case .moderateOrHeavyFreezingRain: return "Heavy Freezing Rain"
        case .lightRainShower: return "Light Rain"
        case .moderateOrHeavyRainShower: return "Heavy Rain"
        case .torrentialRainShower: return "Torrential Rain"
        case .patchySnowPossible: return "Patchy Snow"
        case .patchySleetPossible: return "Patchy Sleet"
        case .patchyFreezingDrizzlePossible: return "Freezing Drizzle"
        case .blowingSnow: return "Blowing Snow"
        case .blizzard: return "Blizzard"
        case .lightSleet: return "Light Sleet"
        case .moderateOrHeavySleet: return "Heavy Sleet"
        case .patchyLightSnow: return "Light Snow"
        case .lightSnow: return "Light Snow"
        case .patchyModerateSnow: return "Moderate Snow"
        case .moderateSnow: return "Moderate Snow"
        case .patchyHeavySnow: return "Heavy Snow"
        case .heavySnow: return "Heavy Snow"
        case .icePellets: return "Ice Pellets"
        case .lightSleetShowers: return "Light Sleet"
        case .moderateOrHeavySleetShowers: return "Heavy Sleet"
        case .lightSnowShowers: return "Light Snow"
        case .moderateOrHeavySnowShowers: return "Heavy Snow"
        case .lightShowersOfIcePellets: return "Ice Pellets"
        case .moderateOrHeavyShowersOfIcePellets: return "Heavy Ice Pellets"
        case .thunderyOutbreaksPossible: return "Thunder Possible"
        case .patchyLightRainWithThunder: return "Thunderstorm"
        case .moderateOrHeavyRainWithThunder: return "Thunderstorm"
        case .patchyLightSnowWithThunder: return "Snow with Thunder"
        case .moderateOrHeavySnowWithThunder: return "Snow with Thunder"
        }
    }
    
    // Get icon code for this condition
    var iconCode: Int {
        switch self {
        case .sunny, .clear: return 113
        case .partlyCloudy: return 116
        case .cloudy: return 119
        case .overcast: return 122
        case .mist: return 143
        case .patchyRainPossible: return 176
        case .patchySnowPossible: return 179
        case .patchySleetPossible: return 182
        case .patchyFreezingDrizzlePossible: return 185
        case .thunderyOutbreaksPossible: return 200
        case .blowingSnow: return 227
        case .blizzard: return 230
        case .fog: return 248
        case .freezingFog: return 260
        case .patchyLightDrizzle: return 263
        case .lightDrizzle: return 266
        case .freezingDrizzle: return 281
        case .heavyFreezingDrizzle: return 284
        case .patchyLightRain: return 293
        case .lightRain: return 296
        case .moderateRainAtTimes: return 299
        case .moderateRain: return 302
        case .heavyRainAtTimes: return 305
        case .heavyRain: return 308
        case .lightFreezingRain: return 311
        case .moderateOrHeavyFreezingRain: return 314
        case .lightSleet: return 317
        case .moderateOrHeavySleet: return 320
        case .patchyLightSnow: return 323
        case .lightSnow: return 326
        case .patchyModerateSnow: return 329
        case .moderateSnow: return 332
        case .patchyHeavySnow: return 335
        case .heavySnow: return 338
        case .icePellets: return 350
        case .lightRainShower: return 353
        case .moderateOrHeavyRainShower: return 356
        case .torrentialRainShower: return 359
        case .lightSleetShowers: return 362
        case .moderateOrHeavySleetShowers: return 365
        case .lightSnowShowers: return 368
        case .moderateOrHeavySnowShowers: return 371
        case .lightShowersOfIcePellets: return 374
        case .moderateOrHeavyShowersOfIcePellets: return 377
        case .patchyLightRainWithThunder: return 386
        case .moderateOrHeavyRainWithThunder: return 389
        case .patchyLightSnowWithThunder: return 392
        case .moderateOrHeavySnowWithThunder: return 395
        }
    }
    
    // Group conditions for visual representation
    var visualCategory: VisualWeatherCategory {
        switch self {
        case .sunny:
            return .sunny
        case .clear:
            return .clear
        case .partlyCloudy:
            return .partlyCloudy
        case .cloudy, .overcast:
            return .cloudy
        case .mist, .fog, .freezingFog:
            return .foggy
        case .patchyRainPossible, .patchyLightDrizzle, .lightDrizzle,
             .patchyLightRain, .lightRain, .lightRainShower:
            return .lightRain
        case .moderateRainAtTimes, .moderateRain, .moderateOrHeavyRainShower:
            return .moderateRain
        case .heavyRainAtTimes, .heavyRain, .torrentialRainShower:
            return .heavyRain
        case .freezingDrizzle, .heavyFreezingDrizzle, .lightFreezingRain,
             .moderateOrHeavyFreezingRain, .patchyFreezingDrizzlePossible:
            return .freezingRain
        case .patchySnowPossible, .patchyLightSnow, .lightSnow, .lightSnowShowers:
            return .lightSnow
        case .patchyModerateSnow, .moderateSnow, .moderateOrHeavySnowShowers:
            return .moderateSnow
        case .patchyHeavySnow, .heavySnow, .blizzard, .blowingSnow:
            return .heavySnow
        case .patchySleetPossible, .lightSleet, .moderateOrHeavySleet,
             .lightSleetShowers, .moderateOrHeavySleetShowers:
            return .sleet
        case .icePellets, .lightShowersOfIcePellets, .moderateOrHeavyShowersOfIcePellets:
            return .icePellets
        case .thunderyOutbreaksPossible, .patchyLightRainWithThunder,
             .moderateOrHeavyRainWithThunder:
            return .thunderstorm
        case .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
            return .thundersnow
        }
    }
    
    // Get background color based on condition
    var backgroundColor: Color {
        switch visualCategory {
        case .sunny:
            return Color(hex: "f1ece1") // Cream/beige
        case .clear:
            return Color(hex: "232b3e") // Dark blue night
        case .partlyCloudy:
            return Color(hex: "9bc0dd") // Light blue with clouds
        case .cloudy:
            return Color(hex: "78909c") // Steel blue
        case .foggy:
            return Color(hex: "9e9e9e") // Gray
        case .lightRain, .moderateRain:
            return Color(hex: "1c3144") // Dark blue
        case .heavyRain:
            return Color(hex: "102027") // Very dark blue
        case .freezingRain, .sleet:
            return Color(hex: "4c6677") // Blue-gray
        case .lightSnow, .moderateSnow:
            return Color(hex: "cfd8dc") // Light blue-gray
        case .heavySnow:
            return Color(hex: "90a4ae") // Medium blue-gray
        case .icePellets:
            return Color(hex: "b0bec5") // Pale blue-gray
        case .thunderstorm:
            return Color(hex: "3c414e") // Dark storm blue
        case .thundersnow:
            return Color(hex: "455a64") // Dark blue-gray
        }
    }
    
    // Get text color based on background
    var textColor: Color {
        switch visualCategory {
        case .lightSnow, .moderateSnow, .sunny, .partlyCloudy:
            return Color(hex: "333333") // Dark text for light backgrounds
        default:
            return .white // Light text for dark backgrounds
        }
    }
}

// MARK: - Visual Categories for Weather Art
enum VisualWeatherCategory {
    case sunny
    case clear
    case partlyCloudy
    case cloudy
    case foggy
    case lightRain
    case moderateRain
    case heavyRain
    case freezingRain
    case lightSnow
    case moderateSnow
    case heavySnow
    case sleet
    case icePellets
    case thunderstorm
    case thundersnow
}

extension WeatherConditionIcon {
   
    
    // Button accent gradient - more subtle version of the theme gradient
    var accentGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                accentColor.opacity(0.8),
                accentColor.opacity(0.6)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // Main accent color based on the weather condition
    var accentColor: Color {
        switch visualCategory {
        case .sunny, .clear:
            return Color(hex: "FF9500")
        case .partlyCloudy, .cloudy, .foggy:
            return Color(hex: "2E87FB")
        case .lightRain, .moderateRain, .heavyRain, .freezingRain:
            return Color(hex: "3C8CE7")
        case .lightSnow, .moderateSnow, .heavySnow, .thundersnow:
            return Color(hex: "5D8DC1")
        case .sleet, .icePellets:
            return Color(hex: "4B87C5")
        case .thunderstorm:
            return Color(hex: "525BF5")
        }
    }
    
   
}
