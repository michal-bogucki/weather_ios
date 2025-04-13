//
//  WeatherApiModelA.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/04/2025.
//

let sampleList = [sample1,sample2,sample3,sample4,sample5]

let sample1 = WeatherResponse(
    location: Location(
        name: "Warszawa",
        region: "Mazowieckie",
        country: "Polska",
        lat: 52.23,
        lon: 21.01,
        tzId: "Europe/Warsaw",
        localtimeEpoch: 1681376400,
        localtime: "2025-04-13 12:00"
    ),
    current: CurrentWeather(
        lastUpdatedEpoch: 1681376100,
        lastUpdated: "2025-04-13 11:55",
        tempC: 18.5,
        tempF: 65.3,
        isDay: 1,
        condition: WeatherCondition(
            text: "Częściowe zachmurzenie",
            icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
            code: 116
        ),
        windKph: 12.6,
        windDegree: 245,
        windDir: "WSW",
        pressureMb: 1016.0,
        precipMm: 0.0,
        humidity: 65,
        cloud: 25,
        feelslikeC: 18.0,
        feelslikeF: 64.4,
        visKm: 10.0,
        uv: 4.0
    ),
    forecast: Forecast(
        forecastday: [
            // Dzień 1 (dzisiaj)
            ForecastDay(
                date: "2025-04-13",
                dateEpoch: 1681344000,
                day: Day(
                    maxtempC: 19.2,
                    maxtempF: 66.6,
                    mintempC: 10.8,
                    mintempF: 51.4,
                    avgtempC: 15.6,
                    avgtempF: 60.1,
                    maxwindKph: 15.8,
                    maxwindMph: 9.8,
                    totalprecipMm: 0.1,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 70.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 20,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Częściowe zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 4.0
                ),
                astro: Astro(
                    sunrise: "05:23 AM",
                    sunset: "07:45 PM",
                    moonrise: "04:12 AM",
                    moonset: "03:21 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "48"
                ),
                hour: []
            ),
            // Dzień 2
            ForecastDay(
                date: "2025-04-14",
                dateEpoch: 1681430400,
                day: Day(
                    maxtempC: 20.5,
                    maxtempF: 68.9,
                    mintempC: 11.2,
                    mintempF: 52.2,
                    avgtempC: 16.2,
                    avgtempF: 61.2,
                    maxwindKph: 13.0,
                    maxwindMph: 8.1,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 65.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 10,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 5.0
                ),
                astro: Astro(
                    sunrise: "05:21 AM",
                    sunset: "07:47 PM",
                    moonrise: "04:45 AM",
                    moonset: "04:36 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "42"
                ),
                hour: []
            ),
            // Dzień 3
            ForecastDay(
                date: "2025-04-15",
                dateEpoch: 1681516800,
                day: Day(
                    maxtempC: 21.4,
                    maxtempF: 70.5,
                    mintempC: 12.6,
                    mintempF: 54.7,
                    avgtempC: 17.3,
                    avgtempF: 63.1,
                    maxwindKph: 11.5,
                    maxwindMph: 7.1,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 60.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 5,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 6.0
                ),
                astro: Astro(
                    sunrise: "05:19 AM",
                    sunset: "07:49 PM",
                    moonrise: "05:12 AM",
                    moonset: "05:51 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "35"
                ),
                hour: []
            ),
            // Dzień 4
            ForecastDay(
                date: "2025-04-16",
                dateEpoch: 1681603200,
                day: Day(
                    maxtempC: 19.8,
                    maxtempF: 67.6,
                    mintempC: 13.1,
                    mintempF: 55.6,
                    avgtempC: 16.5,
                    avgtempF: 61.7,
                    maxwindKph: 18.0,
                    maxwindMph: 11.2,
                    totalprecipMm: 2.5,
                    totalprecipIn: 0.1,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 60,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:17 AM",
                    sunset: "07:51 PM",
                    moonrise: "05:37 AM",
                    moonset: "07:05 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "28"
                ),
                hour: []
            ),
            // Dzień 5
            ForecastDay(
                date: "2025-04-17",
                dateEpoch: 1681689600,
                day: Day(
                    maxtempC: 16.7,
                    maxtempF: 62.1,
                    mintempC: 11.0,
                    mintempF: 51.8,
                    avgtempC: 14.2,
                    avgtempF: 57.6,
                    maxwindKph: 22.0,
                    maxwindMph: 13.7,
                    totalprecipMm: 5.2,
                    totalprecipIn: 0.2,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.0,
                    avgvisMiles: 4.3,
                    avghumidity: 85.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 80,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Intensywne opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/308.png",
                        code: 308
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:15 AM",
                    sunset: "07:53 PM",
                    moonrise: "06:02 AM",
                    moonset: "08:18 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "21"
                ),
                hour: []
            ),
            // Dzień 6
            ForecastDay(
                date: "2025-04-18",
                dateEpoch: 1681776000,
                day: Day(
                    maxtempC: 14.5,
                    maxtempF: 58.1,
                    mintempC: 9.8,
                    mintempF: 49.6,
                    avgtempC: 12.1,
                    avgtempF: 53.8,
                    maxwindKph: 18.5,
                    maxwindMph: 11.5,
                    totalprecipMm: 2.8,
                    totalprecipIn: 0.1,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.0,
                    avgvisMiles: 5.0,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 70,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekkie opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/296.png",
                        code: 296
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:13 AM",
                    sunset: "07:55 PM",
                    moonrise: "06:27 AM",
                    moonset: "09:30 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "14"
                ),
                hour: []
            ),
            // Dzień 7 (dodatkowy)
            ForecastDay(
                date: "2025-04-19",
                dateEpoch: 1681862400,
                day: Day(
                    maxtempC: 15.2,
                    maxtempF: 59.4,
                    mintempC: 8.6,
                    mintempF: 47.5,
                    avgtempC: 12.4,
                    avgtempF: 54.3,
                    maxwindKph: 15.1,
                    maxwindMph: 9.4,
                    totalprecipMm: 1.2,
                    totalprecipIn: 0.05,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 55,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:11 AM",
                    sunset: "07:57 PM",
                    moonrise: "06:55 AM",
                    moonset: "10:42 PM",
                    moonPhase: "Nów",
                    moonIllumination: "7"
                ),
                hour: []
            )
        ]
    )
)

let sample2 = WeatherResponse(
    location: Location(
        name: "Warszawa",
        region: "Mazowieckie",
        country: "Polska",
        lat: 52.23,
        lon: 21.01,
        tzId: "Europe/Warsaw",
        localtimeEpoch: 1681376400,
        localtime: "2025-04-13 12:00"
    ),
    current: CurrentWeather(
        lastUpdatedEpoch: 1681376100,
        lastUpdated: "2025-04-13 11:55",
        tempC: 18.5,
        tempF: 65.3,
        isDay: 1,
        condition: WeatherCondition(
            text: "Częściowe zachmurzenie",
            icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
            code: 116
        ),
        windKph: 12.6,
        windDegree: 245,
        windDir: "WSW",
        pressureMb: 1016.0,
        precipMm: 0.0,
        humidity: 65,
        cloud: 25,
        feelslikeC: 18.0,
        feelslikeF: 64.4,
        visKm: 10.0,
        uv: 4.0
    ),
    forecast: Forecast(
        forecastday: [
            // Dzień 1 (dzisiaj)
            ForecastDay(
                date: "2025-04-13",
                dateEpoch: 1681344000,
                day: Day(
                    maxtempC: 19.2,
                    maxtempF: 66.6,
                    mintempC: 10.8,
                    mintempF: 51.4,
                    avgtempC: 15.6,
                    avgtempF: 60.1,
                    maxwindKph: 15.8,
                    maxwindMph: 9.8,
                    totalprecipMm: 0.1,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 70.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 20,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Częściowe zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 4.0
                ),
                astro: Astro(
                    sunrise: "05:23 AM",
                    sunset: "07:45 PM",
                    moonrise: "04:12 AM",
                    moonset: "03:21 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "48"
                ),
                hour: []
            ),
            // Dzień 2
            ForecastDay(
                date: "2025-04-14",
                dateEpoch: 1681430400,
                day: Day(
                    maxtempC: 20.5,
                    maxtempF: 68.9,
                    mintempC: 11.2,
                    mintempF: 52.2,
                    avgtempC: 16.2,
                    avgtempF: 61.2,
                    maxwindKph: 13.0,
                    maxwindMph: 8.1,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 65.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 10,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 5.0
                ),
                astro: Astro(
                    sunrise: "05:21 AM",
                    sunset: "07:47 PM",
                    moonrise: "04:45 AM",
                    moonset: "04:36 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "42"
                ),
                hour: []
            ),
            // Dzień 3
            ForecastDay(
                date: "2025-04-15",
                dateEpoch: 1681516800,
                day: Day(
                    maxtempC: 21.4,
                    maxtempF: 70.5,
                    mintempC: 12.6,
                    mintempF: 54.7,
                    avgtempC: 17.3,
                    avgtempF: 63.1,
                    maxwindKph: 11.5,
                    maxwindMph: 7.1,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 60.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 5,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 6.0
                ),
                astro: Astro(
                    sunrise: "05:19 AM",
                    sunset: "07:49 PM",
                    moonrise: "05:12 AM",
                    moonset: "05:51 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "35"
                ),
                hour: []
            ),
            // Dzień 4
            ForecastDay(
                date: "2025-04-16",
                dateEpoch: 1681603200,
                day: Day(
                    maxtempC: 19.8,
                    maxtempF: 67.6,
                    mintempC: 13.1,
                    mintempF: 55.6,
                    avgtempC: 16.5,
                    avgtempF: 61.7,
                    maxwindKph: 18.0,
                    maxwindMph: 11.2,
                    totalprecipMm: 2.5,
                    totalprecipIn: 0.1,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 60,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:17 AM",
                    sunset: "07:51 PM",
                    moonrise: "05:37 AM",
                    moonset: "07:05 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "28"
                ),
                hour: []
            ),
            // Dzień 5
            ForecastDay(
                date: "2025-04-17",
                dateEpoch: 1681689600,
                day: Day(
                    maxtempC: 16.7,
                    maxtempF: 62.1,
                    mintempC: 11.0,
                    mintempF: 51.8,
                    avgtempC: 14.2,
                    avgtempF: 57.6,
                    maxwindKph: 22.0,
                    maxwindMph: 13.7,
                    totalprecipMm: 5.2,
                    totalprecipIn: 0.2,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.0,
                    avgvisMiles: 4.3,
                    avghumidity: 85.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 80,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Intensywne opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/308.png",
                        code: 308
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:15 AM",
                    sunset: "07:53 PM",
                    moonrise: "06:02 AM",
                    moonset: "08:18 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "21"
                ),
                hour: []
            ),
            // Dzień 6
            ForecastDay(
                date: "2025-04-18",
                dateEpoch: 1681776000,
                day: Day(
                    maxtempC: 14.5,
                    maxtempF: 58.1,
                    mintempC: 9.8,
                    mintempF: 49.6,
                    avgtempC: 12.1,
                    avgtempF: 53.8,
                    maxwindKph: 18.5,
                    maxwindMph: 11.5,
                    totalprecipMm: 2.8,
                    totalprecipIn: 0.1,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.0,
                    avgvisMiles: 5.0,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 70,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekkie opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/296.png",
                        code: 296
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:13 AM",
                    sunset: "07:55 PM",
                    moonrise: "06:27 AM",
                    moonset: "09:30 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "14"
                ),
                hour: []
            ),
            // Dzień 7 (dodatkowy)
            ForecastDay(
                date: "2025-04-19",
                dateEpoch: 1681862400,
                day: Day(
                    maxtempC: 15.2,
                    maxtempF: 59.4,
                    mintempC: 8.6,
                    mintempF: 47.5,
                    avgtempC: 12.4,
                    avgtempF: 54.3,
                    maxwindKph: 15.1,
                    maxwindMph: 9.4,
                    totalprecipMm: 1.2,
                    totalprecipIn: 0.05,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 55,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:11 AM",
                    sunset: "07:57 PM",
                    moonrise: "06:55 AM",
                    moonset: "10:42 PM",
                    moonPhase: "Nów",
                    moonIllumination: "7"
                ),
                hour: []
            )
        ]
    )
)

let sample3 = WeatherResponse(
    location: Location(
        name: "Gdańsk",
        region: "Pomorskie",
        country: "Polska",
        lat: 54.35,
        lon: 18.65,
        tzId: "Europe/Warsaw",
        localtimeEpoch: 1681376400,
        localtime: "2025-04-13 12:00"
    ),
    current: CurrentWeather(
        lastUpdatedEpoch: 1681376100,
        lastUpdated: "2025-04-13 11:55",
        tempC: 15.2,
        tempF: 59.4,
        isDay: 1,
        condition: WeatherCondition(
            text: "Lekkie zachmurzenie",
            icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
            code: 116
        ),
        windKph: 18.4,
        windDegree: 315,
        windDir: "NW",
        pressureMb: 1018.0,
        precipMm: 0.0,
        humidity: 72,
        cloud: 40,
        feelslikeC: 14.0,
        feelslikeF: 57.2,
        visKm: 10.0,
        uv: 3.0
    ),
    forecast: Forecast(
        forecastday: [
            // Dzień 1 (dzisiaj)
            ForecastDay(
                date: "2025-04-13",
                dateEpoch: 1681344000,
                day: Day(
                    maxtempC: 16.0,
                    maxtempF: 60.8,
                    mintempC: 8.5,
                    mintempF: 47.3,
                    avgtempC: 12.8,
                    avgtempF: 55.0,
                    maxwindKph: 22.0,
                    maxwindMph: 13.7,
                    totalprecipMm: 0.3,
                    totalprecipIn: 0.01,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 75.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 30,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekkie zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:15 AM",
                    sunset: "07:53 PM",
                    moonrise: "04:02 AM",
                    moonset: "03:32 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "48"
                ),
                hour: []
            ),
            // Dzień 2
            ForecastDay(
                date: "2025-04-14",
                dateEpoch: 1681430400,
                day: Day(
                    maxtempC: 17.1,
                    maxtempF: 62.8,
                    mintempC: 9.3,
                    mintempF: 48.7,
                    avgtempC: 13.5,
                    avgtempF: 56.3,
                    maxwindKph: 20.5,
                    maxwindMph: 12.7,
                    totalprecipMm: 0.2,
                    totalprecipIn: 0.01,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 70.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 20,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Częściowe zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:13 AM",
                    sunset: "07:55 PM",
                    moonrise: "04:35 AM",
                    moonset: "04:47 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "42"
                ),
                hour: []
            ),
            // Dzień 3
            ForecastDay(
                date: "2025-04-15",
                dateEpoch: 1681516800,
                day: Day(
                    maxtempC: 18.5,
                    maxtempF: 65.3,
                    mintempC: 10.2,
                    mintempF: 50.4,
                    avgtempC: 14.8,
                    avgtempF: 58.6,
                    maxwindKph: 16.9,
                    maxwindMph: 10.5,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 65.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 10,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 4.0
                ),
                astro: Astro(
                    sunrise: "05:11 AM",
                    sunset: "07:57 PM",
                    moonrise: "05:01 AM",
                    moonset: "06:02 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "35"
                ),
                hour: []
            ),
            // Dzień 4
            ForecastDay(
                date: "2025-04-16",
                dateEpoch: 1681603200,
                day: Day(
                    maxtempC: 16.7,
                    maxtempF: 62.1,
                    mintempC: 11.8,
                    mintempF: 53.2,
                    avgtempC: 14.2,
                    avgtempF: 57.6,
                    maxwindKph: 26.6,
                    maxwindMph: 16.5,
                    totalprecipMm: 1.8,
                    totalprecipIn: 0.07,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.0,
                    avgvisMiles: 5.0,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 65,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:09 AM",
                    sunset: "07:59 PM",
                    moonrise: "05:25 AM",
                    moonset: "07:16 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "28"
                ),
                hour: []
            ),
            // Dzień 5
            ForecastDay(
                date: "2025-04-17",
                dateEpoch: 1681689600,
                day: Day(
                    maxtempC: 14.3,
                    maxtempF: 57.7,
                    mintempC: 8.9,
                    mintempF: 48.0,
                    avgtempC: 11.7,
                    avgtempF: 53.1,
                    maxwindKph: 28.8,
                    maxwindMph: 17.9,
                    totalprecipMm: 4.6,
                    totalprecipIn: 0.18,
                    totalsnowCm: 0.0,
                    avgvisKm: 6.0,
                    avgvisMiles: 3.7,
                    avghumidity: 85.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 85,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Intensywne opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/308.png",
                        code: 308
                    ),
                    uv: 1.0
                ),
                astro: Astro(
                    sunrise: "05:07 AM",
                    sunset: "08:01 PM",
                    moonrise: "05:48 AM",
                    moonset: "08:29 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "21"
                ),
                hour: []
            ),
            // Dzień 6
            ForecastDay(
                date: "2025-04-18",
                dateEpoch: 1681776000,
                day: Day(
                    maxtempC: 12.1,
                    maxtempF: 53.8,
                    mintempC: 7.5,
                    mintempF: 45.5,
                    avgtempC: 9.8,
                    avgtempF: 49.6,
                    maxwindKph: 25.2,
                    maxwindMph: 15.7,
                    totalprecipMm: 3.2,
                    totalprecipIn: 0.13,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.0,
                    avgvisMiles: 4.3,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 75,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 1.0
                ),
                astro: Astro(
                    sunrise: "05:05 AM",
                    sunset: "08:03 PM",
                    moonrise: "06:12 AM",
                    moonset: "09:41 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "14"
                ),
                hour: []
            ),
            // Dzień 7
            ForecastDay(
                date: "2025-04-19",
                dateEpoch: 1681862400,
                day: Day(
                    maxtempC: 13.6,
                    maxtempF: 56.5,
                    mintempC: 6.8,
                    mintempF: 44.2,
                    avgtempC: 10.5,
                    avgtempF: 50.9,
                    maxwindKph: 18.7,
                    maxwindMph: 11.6,
                    totalprecipMm: 1.2,
                    totalprecipIn: 0.05,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.5,
                    avgvisMiles: 5.3,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 60,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:03 AM",
                    sunset: "08:05 PM",
                    moonrise: "06:40 AM",
                    moonset: "10:51 PM",
                    moonPhase: "Nów",
                    moonIllumination: "7"
                ),
                hour: []
            )
        ]
    )
)

let sample4 = WeatherResponse(
    location: Location(
        name: "Kielce",
        region: "Świętokrzyskie",
        country: "Polska",
        lat: 50.87,
        lon: 20.63,
        tzId: "Europe/Warsaw",
        localtimeEpoch: 1681376400,
        localtime: "2025-04-13 12:00"
    ),
    current: CurrentWeather(
        lastUpdatedEpoch: 1681376100,
        lastUpdated: "2025-04-13 11:55",
        tempC: 17.2,
        tempF: 63.0,
        isDay: 1,
        condition: WeatherCondition(
            text: "Częściowe zachmurzenie",
            icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
            code: 116
        ),
        windKph: 10.8,
        windDegree: 230,
        windDir: "SW",
        pressureMb: 1014.0,
        precipMm: 0.0,
        humidity: 62,
        cloud: 30,
        feelslikeC: 17.0,
        feelslikeF: 62.6,
        visKm: 10.0,
        uv: 4.0
    ),
    forecast: Forecast(
        forecastday: [
            // Dzień 1 (dzisiaj)
            ForecastDay(
                date: "2025-04-13",
                dateEpoch: 1681344000,
                day: Day(
                    maxtempC: 18.7,
                    maxtempF: 65.7,
                    mintempC: 9.8,
                    mintempF: 49.6,
                    avgtempC: 14.5,
                    avgtempF: 58.1,
                    maxwindKph: 14.4,
                    maxwindMph: 8.9,
                    totalprecipMm: 0.2,
                    totalprecipIn: 0.01,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 68.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 15,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Częściowe zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 4.0
                ),
                astro: Astro(
                    sunrise: "05:25 AM",
                    sunset: "07:42 PM",
                    moonrise: "04:10 AM",
                    moonset: "03:25 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "48"
                ),
                hour: []
            ),
            // Dzień 2
            ForecastDay(
                date: "2025-04-14",
                dateEpoch: 1681430400,
                day: Day(
                    maxtempC: 19.5,
                    maxtempF: 67.1,
                    mintempC: 10.2,
                    mintempF: 50.4,
                    avgtempC: 15.3,
                    avgtempF: 59.5,
                    maxwindKph: 12.6,
                    maxwindMph: 7.8,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 65.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 5,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 5.0
                ),
                astro: Astro(
                    sunrise: "05:23 AM",
                    sunset: "07:44 PM",
                    moonrise: "04:42 AM",
                    moonset: "04:40 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "42"
                ),
                hour: []
            ),
            // Dzień 3
            ForecastDay(
                date: "2025-04-15",
                dateEpoch: 1681516800,
                day: Day(
                    maxtempC: 20.8,
                    maxtempF: 69.4,
                    mintempC: 11.5,
                    mintempF: 52.7,
                    avgtempC: 16.7,
                    avgtempF: 62.1,
                    maxwindKph: 10.8,
                    maxwindMph: 6.7,
                    totalprecipMm: 0.0,
                    totalprecipIn: 0.0,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 60.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 0,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Słonecznie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 113
                    ),
                    uv: 5.0
                ),
                astro: Astro(
                    sunrise: "05:21 AM",
                    sunset: "07:46 PM",
                    moonrise: "05:08 AM",
                    moonset: "05:54 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "35"
                ),
                hour: []
            ),
            // Dzień 4
            ForecastDay(
                date: "2025-04-16",
                dateEpoch: 1681603200,
                day: Day(
                    maxtempC: 19.4,
                    maxtempF: 66.9,
                    mintempC: 12.3,
                    mintempF: 54.1,
                    avgtempC: 16.0,
                    avgtempF: 60.8,
                    maxwindKph: 16.2,
                    maxwindMph: 10.1,
                    totalprecipMm: 1.2,
                    totalprecipIn: 0.05,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.2,
                    avgvisMiles: 5.7,
                    avghumidity: 70.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 55,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:19 AM",
                    sunset: "07:48 PM",
                    moonrise: "05:32 AM",
                    moonset: "07:08 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "28"
                ),
                hour: []
            ),
            // Dzień 5
            ForecastDay(
                date: "2025-04-17",
                dateEpoch: 1681689600,
                day: Day(
                    maxtempC: 17.5,
                    maxtempF: 63.5,
                    mintempC: 10.8,
                    mintempF: 51.4,
                    avgtempC: 14.6,
                    avgtempF: 58.3,
                    maxwindKph: 19.8,
                    maxwindMph: 12.3,
                    totalprecipMm: 3.6,
                    totalprecipIn: 0.14,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.5,
                    avgvisMiles: 4.7,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 75,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:17 AM",
                    sunset: "07:50 PM",
                    moonrise: "05:57 AM",
                    moonset: "08:21 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "21"
                ),
                hour: []
            ),
            // Dzień 6
            ForecastDay(
                date: "2025-04-18",
                dateEpoch: 1681776000,
                day: Day(
                    maxtempC: 15.3,
                    maxtempF: 59.5,
                    mintempC: 9.2,
                    mintempF: 48.6,
                    avgtempC: 12.5,
                    avgtempF: 54.5,
                    maxwindKph: 17.3,
                    maxwindMph: 10.7,
                    totalprecipMm: 2.2,
                    totalprecipIn: 0.09,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.3,
                    avgvisMiles: 5.2,
                    avghumidity: 78.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 65,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:15 AM",
                    sunset: "07:51 PM",
                    moonrise: "06:22 AM",
                    moonset: "09:33 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "14"
                ),
                hour: []
            ),
            // Dzień 7
            ForecastDay(
                date: "2025-04-19",
                dateEpoch: 1681862400,
                day: Day(
                    maxtempC: 14.8,
                    maxtempF: 58.6,
                    mintempC: 8.5,
                    mintempF: 47.3,
                    avgtempC: 11.9,
                    avgtempF: 53.4,
                    maxwindKph: 14.8,
                    maxwindMph: 9.2,
                    totalprecipMm: 1.0,
                    totalprecipIn: 0.04,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 45,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Zachmurzenie z przejaśnieniami",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:13 AM",
                    sunset: "07:53 PM",
                    moonrise: "06:50 AM",
                    moonset: "10:44 PM",
                    moonPhase: "Nów",
                    moonIllumination: "7"
                ),
                hour: []
            )
        ]
    )
)

let sample5 = WeatherResponse(
    location: Location(
        name: "Szczecin",
        region: "Zachodniopomorskie",
        country: "Polska",
        lat: 53.43,
        lon: 14.55,
        tzId: "Europe/Warsaw",
        localtimeEpoch: 1681376400,
        localtime: "2025-04-13 12:00"
    ),
    current: CurrentWeather(
        lastUpdatedEpoch: 1681376100,
        lastUpdated: "2025-04-13 11:55",
        tempC: 13.5,
        tempF: 56.3,
        isDay: 1,
        condition: WeatherCondition(
            text: "Umiarkowane opady deszczu",
            icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
            code: 302
        ),
        windKph: 24.1,
        windDegree: 290,
        windDir: "WNW",
        pressureMb: 1008.0,
        precipMm: 3.2,
        humidity: 86,
        cloud: 90,
        feelslikeC: 11.8,
        feelslikeF: 53.2,
        visKm: 6.0,
        uv: 1.0
    ),
    forecast: Forecast(
        forecastday: [
            // Dzień 1 (dzisiaj) - deszczowy
            ForecastDay(
                date: "2025-04-13",
                dateEpoch: 1681344000,
                day: Day(
                    maxtempC: 14.2,
                    maxtempF: 57.6,
                    mintempC: 7.8,
                    mintempF: 46.0,
                    avgtempC: 11.5,
                    avgtempF: 52.7,
                    maxwindKph: 28.8,
                    maxwindMph: 17.9,
                    totalprecipMm: 8.6,
                    totalprecipIn: 0.34,
                    totalsnowCm: 0.0,
                    avgvisKm: 5.0,
                    avgvisMiles: 3.1,
                    avghumidity: 88.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 90,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane do ciężkich opadów deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/305.png",
                        code: 305
                    ),
                    uv: 1.0
                ),
                astro: Astro(
                    sunrise: "05:13 AM",
                    sunset: "07:56 PM",
                    moonrise: "04:00 AM",
                    moonset: "03:28 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "48"
                ),
                hour: []
            ),
            // Dzień 2 - pochmurno z opadami
            ForecastDay(
                date: "2025-04-14",
                dateEpoch: 1681430400,
                day: Day(
                    maxtempC: 15.3,
                    maxtempF: 59.5,
                    mintempC: 8.5,
                    mintempF: 47.3,
                    avgtempC: 12.4,
                    avgtempF: 54.3,
                    maxwindKph: 22.3,
                    maxwindMph: 13.9,
                    totalprecipMm: 4.2,
                    totalprecipIn: 0.17,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.0,
                    avgvisMiles: 4.3,
                    avghumidity: 82.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 75,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:11 AM",
                    sunset: "07:58 PM",
                    moonrise: "04:28 AM",
                    moonset: "04:42 PM",
                    moonPhase: "Trzecia kwadra",
                    moonIllumination: "42"
                ),
                hour: []
            ),
            // Dzień 3 - poprawiająca się pogoda
            ForecastDay(
                date: "2025-04-15",
                dateEpoch: 1681516800,
                day: Day(
                    maxtempC: 16.8,
                    maxtempF: 62.2,
                    mintempC: 9.5,
                    mintempF: 49.1,
                    avgtempC: 13.4,
                    avgtempF: 56.1,
                    maxwindKph: 18.0,
                    maxwindMph: 11.2,
                    totalprecipMm: 1.0,
                    totalprecipIn: 0.04,
                    totalsnowCm: 0.0,
                    avgvisKm: 9.0,
                    avgvisMiles: 5.6,
                    avghumidity: 75.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 60,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Zachmurzenie z przejaśnieniami",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:08 AM",
                    sunset: "08:00 PM",
                    moonrise: "04:54 AM",
                    moonset: "05:55 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "35"
                ),
                hour: []
            ),
            // Dzień 4 - względnie ładna pogoda
            ForecastDay(
                date: "2025-04-16",
                dateEpoch: 1681603200,
                day: Day(
                    maxtempC: 17.4,
                    maxtempF: 63.3,
                    mintempC: 10.2,
                    mintempF: 50.4,
                    avgtempC: 14.3,
                    avgtempF: 57.7,
                    maxwindKph: 16.2,
                    maxwindMph: 10.1,
                    totalprecipMm: 0.3,
                    totalprecipIn: 0.01,
                    totalsnowCm: 0.0,
                    avgvisKm: 10.0,
                    avgvisMiles: 6.2,
                    avghumidity: 70.0,
                    dailyWillItRain: 0,
                    dailyChanceOfRain: 20,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Częściowe zachmurzenie",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                        code: 116
                    ),
                    uv: 3.0
                ),
                astro: Astro(
                    sunrise: "05:06 AM",
                    sunset: "08:02 PM",
                    moonrise: "05:18 AM",
                    moonset: "07:08 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "28"
                ),
                hour: []
            ),
            // Dzień 5 - powrót deszczu
            ForecastDay(
                date: "2025-04-17",
                dateEpoch: 1681689600,
                day: Day(
                    maxtempC: 15.2,
                    maxtempF: 59.4,
                    mintempC: 9.8,
                    mintempF: 49.6,
                    avgtempC: 12.5,
                    avgtempF: 54.5,
                    maxwindKph: 25.2,
                    maxwindMph: 15.7,
                    totalprecipMm: 4.8,
                    totalprecipIn: 0.19,
                    totalsnowCm: 0.0,
                    avgvisKm: 7.0,
                    avgvisMiles: 4.3,
                    avghumidity: 84.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 80,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:04 AM",
                    sunset: "08:04 PM",
                    moonrise: "05:42 AM",
                    moonset: "08:20 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "21"
                ),
                hour: []
            ),
            // Dzień 6 - wciąż deszczowo
            ForecastDay(
                date: "2025-04-18",
                dateEpoch: 1681776000,
                day: Day(
                    maxtempC: 13.6,
                    maxtempF: 56.5,
                    mintempC: 8.2,
                    mintempF: 46.8,
                    avgtempC: 11.0,
                    avgtempF: 51.8,
                    maxwindKph: 27.0,
                    maxwindMph: 16.8,
                    totalprecipMm: 5.6,
                    totalprecipIn: 0.22,
                    totalsnowCm: 0.0,
                    avgvisKm: 6.0,
                    avgvisMiles: 3.7,
                    avghumidity: 85.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 85,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Umiarkowane opady deszczu",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/302.png",
                        code: 302
                    ),
                    uv: 1.0
                ),
                astro: Astro(
                    sunrise: "05:02 AM",
                    sunset: "08:06 PM",
                    moonrise: "06:06 AM",
                    moonset: "09:32 PM",
                    moonPhase: "Malejący sierp",
                    moonIllumination: "14"
                ),
                hour: []
            ),
            // Dzień 7 - stopniowa poprawa
            ForecastDay(
                date: "2025-04-19",
                dateEpoch: 1681862400,
                day: Day(
                    maxtempC: 14.3,
                    maxtempF: 57.7,
                    mintempC: 7.5,
                    mintempF: 45.5,
                    avgtempC: 11.5,
                    avgtempF: 52.7,
                    maxwindKph: 21.6,
                    maxwindMph: 13.4,
                    totalprecipMm: 2.8,
                    totalprecipIn: 0.11,
                    totalsnowCm: 0.0,
                    avgvisKm: 8.0,
                    avgvisMiles: 5.0,
                    avghumidity: 80.0,
                    dailyWillItRain: 1,
                    dailyChanceOfRain: 70,
                    dailyWillItSnow: 0,
                    dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Lekki deszcz przelotny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/293.png",
                        code: 293
                    ),
                    uv: 2.0
                ),
                astro: Astro(
                    sunrise: "05:00 AM",
                    sunset: "08:08 PM",
                    moonrise: "06:32 AM",
                    moonset: "10:43 PM",
                    moonPhase: "Nów",
                    moonIllumination: "7"
                ),
                hour: []
            )
        ]
    )
)


