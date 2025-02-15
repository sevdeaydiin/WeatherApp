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

#Preview {
    ContentView()
} 
