//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Sevde Aydın on 2/16/25.
//

import XCTest
import Combine
@testable import WeatherApp

// MARK: - Mock Classes

class MockWeatherService: WeatherServiceProtocol {
    private let result: Result<WeatherData, Error>
    
    init(result: Result<WeatherData, Error>) {
        self.result = result
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherData, Error> {
        return result.publisher
            .delay(for: .milliseconds(100), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
