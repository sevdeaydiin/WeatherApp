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
