//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 12/6/24.
//

import Foundation

protocol WeatherViewModelProtocol: ObservableObject {
    associatedtype T
    var state: ViewState<T> { get }
    func fetchWeather(for city: String)
}

enum ViewState<T> {
    case defaultState
    case loading
    case success(T)
    case error(String)
}

class WeatherViewModel: WeatherViewModelProtocol {
    @Published private(set) var state: ViewState<Weather> = .defaultState
    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) {
        state = .loading
        Task {
            do {
                let weather = try await weatherService.fetchWeather(for: city)
                DispatchQueue.main.async {
                    self.state = .success(weather)
                }
            } catch let error as WeatherError {
                DispatchQueue.main.async {
                    self.state = .error(error.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error(WeatherError.unknown.message)
                }
            }
        }
    }
}

