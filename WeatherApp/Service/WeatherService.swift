//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 12/6/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> Weather
}

enum WeatherError: Error {
    case invalidCity
    case networkError
    case unknown

    var message: String {
        switch self {
        case .invalidCity: return "Invalid city name."
        case .networkError: return "Network connection error."
        case .unknown: return "An unknown error occurred."
        }
    }
}

class WeatherService: WeatherServiceProtocol {
    
    func fetchWeather(for city: String) async throws -> Weather {
        let conditions: [WeatherCondition] = [.sunny, .cloudy, .rainy, .snowy]
        guard !city.isEmpty else { throw WeatherError.invalidCity }
        return Weather(
            city: city,
            temperature: Double.random(in: -10...40),
            condition: conditions.randomElement()!
        )
    }
}

