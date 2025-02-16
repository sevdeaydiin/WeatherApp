//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Sevde Aydın on 2/16/25.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    // MARK: - WeatherViewModel Tests
    
    func testWeatherViewModel_WhenSearchWeatherSucceeds_ShouldUpdateWeatherData() {
        // Given
        let expectation = expectation(description: "Weather data should be updated")
        let mockService = MockWeatherService(result: .success(MockData.weatherData))
        let viewModel = WeatherViewModel(weatherService: mockService)
        
        // When
        viewModel.searchWeather(for: "Istanbul")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(viewModel.weatherData)
            XCTAssertEqual(viewModel.weatherData?.cityName, "Istanbul")
            XCTAssertEqual(viewModel.weatherData?.temperature, 20.5)
            XCTAssertNil(viewModel.error)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWeatherViewModel_WhenSearchWeatherFails_ShouldShowError() {
        // Given
        let expectation = expectation(description: "Error should be shown")
        let mockService = MockWeatherService(result: .failure(NetworkError.invalidResponse))
        let viewModel = WeatherViewModel(weatherService: mockService)
        
        // When
        viewModel.searchWeather(for: "InvalidCity")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(viewModel.weatherData)
            XCTAssertNotNil(viewModel.error)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWeatherViewModel_WhenSearching_ShouldShowLoadingState() {
        // Given
        let mockService = MockWeatherService(result: .success(MockData.weatherData))
        let viewModel = WeatherViewModel(weatherService: mockService)
        
        // When
        viewModel.searchWeather(for: "Istanbul")
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
    }
    
    // MARK: - WeatherService Tests
    
    func testWeatherService_WithValidCity_ShouldReturnWeatherData() {
        // Given
        let service = WeatherService()
        let expectation = expectation(description: "Should return weather data")
        var receivedWeatherData: WeatherData?
        var receivedError: Error?
        
        // When
        service.fetchWeather(for: "Istanbul")
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
                expectation.fulfill()
            } receiveValue: { weatherData in
                receivedWeatherData = weatherData
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(receivedWeatherData)
        XCTAssertNil(receivedError)
    }
}
