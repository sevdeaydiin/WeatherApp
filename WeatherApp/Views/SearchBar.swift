//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Sevde Aydın on 2/15/25.
//

import SwiftUI

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
                    .accessibilityIdentifier("searchTextField")
                    .accessibilityAction(named: "Search") {
                        onSubmit()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                    .accessibilityIdentifier("clearButton")
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
        .frame(maxHeight: 80)
    }
}
