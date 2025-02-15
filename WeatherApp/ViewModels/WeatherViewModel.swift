import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherDataViewModel?
    @Published var isLoading = false
    @Published var error: String?
    
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func searchWeather(for city: String) {
        isLoading = true
        error = nil
        
        weatherService.fetchWeather(for: city)
            .map { self.mapToViewModel($0) }
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = "Hava durumu bilgisi alınamadı: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] weatherData in
                self?.weatherData = weatherData
            }
            .store(in: &cancellables)
    }
    
    private func mapToViewModel(_ data: WeatherData) -> WeatherDataViewModel {
        return WeatherDataViewModel(
            cityName: data.name,
            temperature: data.main.temp,
            feelsLike: data.main.feels_like,
            humidity: data.main.humidity,
            windSpeed: data.wind.speed,
            description: data.weather.first?.description ?? "",
            icon: data.weather.first?.icon ?? "",
            sunrise: Date(timeIntervalSince1970: TimeInterval(data.sys.sunrise)),
            sunset: Date(timeIntervalSince1970: TimeInterval(data.sys.sunset))
        )
    }
} 
