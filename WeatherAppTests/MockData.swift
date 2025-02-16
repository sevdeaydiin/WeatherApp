//
//  MockData.swift
//  WeatherAppTests
//
//  Created by Sevde Aydın on 2/16/25.
//

@testable import WeatherApp

// MARK: - Mock Data

enum MockData {
    static let weatherData = WeatherData(
        name: "Istanbul",
        main: Main(
            temp: 20.5,
            feels_like: 19.8,
            humidity: 65
        ),
        weather: [
            Weather(
                id: 800,
                description: "clear sky",
                icon: "01d"
            )
        ],
        wind: Wind(speed: 5.5),
        sys: Sys(sunrise: 1613451600, sunset: 1613491200)
    )
}
