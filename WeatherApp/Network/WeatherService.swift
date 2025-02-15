import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherData, Error>
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "375b38f6a5a521e6685c3f12b054146f"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherData, Error> {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?q=\(encodedCity)&appid=\(apiKey)&units=metric") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
} 
