//
//  WeatherInfoRow.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 2/15/25.
//

import SwiftUI

struct WeatherInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
            
            Text(title)
            
            Spacer()
            
            Text(value)
                .bold()
        }
        .foregroundColor(.primary)
        .padding(.vertical, 8)
    }
}

#Preview {
    WeatherInfoRow(icon: "sun", title: "konya", value: "13.0")
}
