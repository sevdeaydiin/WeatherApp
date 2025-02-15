import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                SearchBar(text: $searchText, onSubmit: {
                    viewModel.searchWeather(for: searchText)
                })
                .padding(.horizontal, 20)
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if let weather = viewModel.weatherData {
                    WeatherDetailView(weather: weather)
                } else {
                    Text("Bir şehir adı girin.")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSubmit: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 18))
                
                TextField("Şehir ara...", text: $text)
                    .foregroundColor(.black)
                    .submitLabel(.search)
                    .onSubmit(onSubmit)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 80)
    }
}

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

struct WeatherInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    ContentView()
} 
