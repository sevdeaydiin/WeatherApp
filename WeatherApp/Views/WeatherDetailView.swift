//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 2/15/25.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherDataViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(weather.cityName)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text(weather.temperatureString)
                .font(.system(size: 70, weight: .thin))
                .foregroundColor(.white)
            
            VStack(spacing: 8) {
                WeatherInfoRow(icon: "thermometer", title: "Hissedilen", value: weather.feelsLikeString)
                WeatherInfoRow(icon: "humidity", title: "Nem", value: weather.humidityString)
                WeatherInfoRow(icon: "wind", title: "Rüzgar", value: weather.windSpeedString)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
