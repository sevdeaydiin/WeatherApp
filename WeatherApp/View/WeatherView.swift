//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 12/6/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel(weatherService: WeatherService())
    @State private var city: String = ""
    
    var body: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack (spacing: 140) {
                HStack (spacing: 10) {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                    
                    TextField("Search", text: $city)
                        .font(.title3)
                        .padding(.leading, 8)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                    
                    Button(action: {
                        viewModel.fetchWeather(for: city)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 80)
                
                
                switch viewModel.state {
                case .defaultState:
                    Text("Bir şehir adı girin.")
                        .foregroundColor(.white)
                        .padding(.bottom, 100)
                case .loading:
                    ProgressView("Yükleniyor...")
                        .foregroundColor(.white)
                        .padding(.bottom, 100)
                case .success(let weather):
                    VStack(spacing: 16) {
                        Image(systemName: weather.condition.iconName)
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                        
                        Text("\(String(format: "%.0f", weather.temperature))°C")
                            .font(.system(size: 80))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text(weather.city)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                case .error(let message):
                    Text(message)
                        .foregroundColor(.red)
                        .padding(.bottom, 100)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    WeatherView()
}


