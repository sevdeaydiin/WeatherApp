//
//  Weather.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 12/6/24.
//

import Foundation

struct Weather {
    let city: String
    let temperature: Double
    let condition: WeatherCondition
}

enum WeatherCondition: String {
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case rainy = "Rainy"
    case snowy = "Snowy"

    var iconName: String {
        switch self {
        case .sunny: return "sun.max"
        case .cloudy: return "cloud"
        case .rainy: return "cloud.rain"
        case .snowy: return "snowflake"
        }
    }
}
