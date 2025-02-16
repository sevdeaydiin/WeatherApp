import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

// View Model'de kullanılacak olan model
struct WeatherDataViewModel {
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let description: String
    let icon: String
    let sunrise: Date
    let sunset: Date
    
    var temperatureString: String {
        return String(format: "%.1f°C", temperature)
    }
    
    var feelsLikeString: String {
        return String(format: "%.1f°C", feelsLike)
    }
    
    var humidityString: String {
        return "\(humidity)%"
    }
    
    var windSpeedString: String {
        return String(format: "%.1f km/h", windSpeed)
    }
} 
