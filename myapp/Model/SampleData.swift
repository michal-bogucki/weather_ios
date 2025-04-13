//
//  SampleData.swift
//  Weather application_
//
//  Created by Michał Bogucki on 13/04/2025.
//

let sampleData: [WeatherLocation] = [
    // Warszawa - słonecznie
    WeatherLocation(
        id: 1,
        name: "Warszawa",
        region: "Mazowieckie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 22,
        feels: 23,
        high: 24,
        low: 12,
        wind: 8,
        humidity: 45,
        sunrise: "05:17",
        sunset: "19:45",
        pressure: 1013,
        uvIndex: "5.2",
        visibility: 20,
        windDirection: "NW",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 0,
        condition: .sunny,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Kraków - deszczowo
    WeatherLocation(
        id: 2,
        name: "Kraków",
        region: "Małopolskie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 14,
        feels: 12,
        high: 16,
        low: 9,
        wind: 12,
        humidity: 78,
        sunrise: "05:20",
        sunset: "19:42",
        pressure: 1008,
        uvIndex: "2.1",
        visibility: 8,
        windDirection: "SW",
        airQuality: "Umiarkowana",
        moonPhase: "Pełnia",
        precipitation: 70,
        condition: .moderateRain,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Gdańsk - pochmurno
    WeatherLocation(
        id: 3,
        name: "Gdańsk",
        region: "Pomorskie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 16,
        feels: 14,
        high: 17,
        low: 10,
        wind: 18,
        humidity: 62,
        sunrise: "05:10",
        sunset: "19:50",
        pressure: 1010,
        uvIndex: "3.4",
        visibility: 15,
        windDirection: "N",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 20,
        condition: .cloudy,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Zakopane - śnieg
    WeatherLocation(
        id: 4,
        name: "Zakopane",
        region: "Małopolskie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 2,
        feels: -1,
        high: 3,
        low: -2,
        wind: 5,
        humidity: 85,
        sunrise: "05:25",
        sunset: "19:38",
        pressure: 998,
        uvIndex: "1.8",
        visibility: 5,
        windDirection: "SE",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 80,
        condition: .lightSnow,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Wrocław - mgła
    WeatherLocation(
        id: 5,
        name: "Wrocław",
        region: "Dolnośląskie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 15,
        feels: 14,
        high: 18,
        low: 11,
        wind: 6,
        humidity: 90,
        sunrise: "05:22",
        sunset: "19:44",
        pressure: 1012,
        uvIndex: "1.2",
        visibility: 2,
        windDirection: "SE",
        airQuality: "Umiarkowana",
        moonPhase: "Pełnia",
        precipitation: 10,
        condition: .fog,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Poznań - częściowe zachmurzenie
    WeatherLocation(
        id: 6,
        name: "Poznań",
        region: "Wielkopolskie",
        country: "Polska",
        date: "Niedziela, 13 kwietnia",
        temp: 18,
        feels: 17,
        high: 20,
        low: 10,
        wind: 10,
        humidity: 55,
        sunrise: "05:18",
        sunset: "19:47",
        pressure: 1015,
        uvIndex: "4.5",
        visibility: 18,
        windDirection: "W",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 5,
        condition: .partlyCloudy,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Barcelona - słonecznie, ciepło
    WeatherLocation(
        id: 7,
        name: "Barcelona",
        region: "Katalonia",
        country: "Hiszpania",
        date: "Niedziela, 13 kwietnia",
        temp: 26,
        feels: 28,
        high: 29,
        low: 19,
        wind: 8,
        humidity: 40,
        sunrise: "06:15",
        sunset: "20:10",
        pressure: 1018,
        uvIndex: "8.7",
        visibility: 25,
        windDirection: "SE",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 0,
        condition: .sunny,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Londyn - deszcz ze śniegiem
    WeatherLocation(
        id: 8,
        name: "Londyn",
        region: "Anglia",
        country: "Wielka Brytania",
        date: "Niedziela, 13 kwietnia",
        temp: 9,
        feels: 6,
        high: 11,
        low: 5,
        wind: 15,
        humidity: 82,
        sunrise: "06:05",
        sunset: "19:55",
        pressure: 1002,
        uvIndex: "1.5",
        visibility: 7,
        windDirection: "SW",
        airQuality: "Umiarkowana",
        moonPhase: "Pełnia",
        precipitation: 65,
        condition: .lightSleet,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Nowy Jork - burza
    WeatherLocation(
        id: 9,
        name: "Nowy Jork",
        region: "Nowy Jork",
        country: "Stany Zjednoczone",
        date: "Niedziela, 13 kwietnia",
        temp: 23,
        feels: 24,
        high: 25,
        low: 18,
        wind: 20,
        humidity: 75,
        sunrise: "06:20",
        sunset: "19:35",
        pressure: 1000,
        uvIndex: "3.2",
        visibility: 6,
        windDirection: "S",
        airQuality: "Umiarkowana",
        moonPhase: "Pełnia",
        precipitation: 85,
        condition: .moderateOrHeavyRainWithThunder,
        weeklyForecast: sampleDailyForecasts
    ),
    
    // Sydney - ciepło, słonecznie
    WeatherLocation(
        id: 10,
        name: "Sydney",
        region: "Nowa Południowa Walia",
        country: "Australia",
        date: "Niedziela, 13 kwietnia",
        temp: 31,
        feels: 33,
        high: 34,
        low: 22,
        wind: 12,
        humidity: 38,
        sunrise: "06:30",
        sunset: "17:45",
        pressure: 1016,
        uvIndex: "9.8",
        visibility: 30,
        windDirection: "NE",
        airQuality: "Dobra",
        moonPhase: "Pełnia",
        precipitation: 0,
        condition: .sunny,
        weeklyForecast: sampleDailyForecasts
    )
]


let sampleDailyForecasts: [DailyForecast] = [
    // Dzisiaj - Niedziela
    DailyForecast(
        day: "Niedziela",
        date: "13 kwietnia",
        high: 22,
        low: 12,
        condition: .sunny,
        precipitation: 5,
        wind: 8,
        uvIndex: 7,
        humidity: 45,
        sunrise: "05:17",
        sunset: "19:45",
        pressure: 1013,
        visibility: 20
    ),
    
    // Poniedziałek - Pochmurno
    DailyForecast(
        day: "Poniedziałek",
        date: "14 kwietnia",
        high: 19,
        low: 11,
        condition: .partlyCloudy,
        precipitation: 25,
        wind: 12,
        uvIndex: 5,
        humidity: 55,
        sunrise: "05:15",
        sunset: "19:47",
        pressure: 1010,
        visibility: 18
    ),
    
    // Wtorek - Deszcz
    DailyForecast(
        day: "Wtorek",
        date: "15 kwietnia",
        high: 16,
        low: 10,
        condition: .moderateRain,
        precipitation: 70,
        wind: 15,
        uvIndex: 3,
        humidity: 78,
        sunrise: "05:13",
        sunset: "19:49",
        pressure: 1008,
        visibility: 10
    ),
    
    // Środa - Burza
    DailyForecast(
        day: "Środa",
        date: "16 kwietnia",
        high: 18,
        low: 12,
        condition: .patchyLightRainWithThunder,
        precipitation: 80,
        wind: 20,
        uvIndex: 2,
        humidity: 85,
        sunrise: "05:11",
        sunset: "19:51",
        pressure: 1005,
        visibility: 8
    ),
    
    // Czwartek - Lekki deszcz
    DailyForecast(
        day: "Czwartek",
        date: "17 kwietnia",
        high: 20,
        low: 13,
        condition: .lightRain,
        precipitation: 40,
        wind: 10,
        uvIndex: 4,
        humidity: 65,
        sunrise: "05:09",
        sunset: "19:53",
        pressure: 1012,
        visibility: 15
    ),
    
    // Piątek - Pogodnie
    DailyForecast(
        day: "Piątek",
        date: "18 kwietnia",
        high: 24,
        low: 14,
        condition: .sunny,
        precipitation: 0,
        wind: 6,
        uvIndex: 8,
        humidity: 40,
        sunrise: "05:07",
        sunset: "19:55",
        pressure: 1015,
        visibility: 25
    ),
    
    // Sobota - Lekkie zachmurzenie
    DailyForecast(
        day: "Sobota",
        date: "19 kwietnia",
        high: 25,
        low: 15,
        condition: .partlyCloudy,
        precipitation: 10,
        wind: 7,
        uvIndex: 7,
        humidity: 45,
        sunrise: "05:05",
        sunset: "19:57",
        pressure: 1014,
        visibility: 22
    )
]
