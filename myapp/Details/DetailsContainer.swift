//
//  DetailsContainer.swift
//  Weather application_
//
//  Created by Michał Bogucki on 11/04/2025.
//

import SwiftUICore
import SwiftUI

struct DetailsContainer: View {
    @ObservedObject var presenter: DetailsPresenter
    
    var body: some View {
        let day = presenter.selectedLocation
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Button(action: {presenter.didTapBack.send()}) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                        
                        Text(day.day)
                            .font(.system(size: 20, weight: .medium))
                    }
                    .padding(8)
                    .background(Color.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(day.condition.textColor.opacity(0.3), lineWidth: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding(16)
            
            ZStack {
                WeatherArtView(condition: day.condition, size: 180)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                
                GeometryReader { geometry in
                    Text(day.condition.displayName)
                        .font(.system(size: 32, weight: .light))
                        .rotationEffect(.degrees(-90))
                        .position(
                            x: UIScreen.main.bounds.width - 20,
                            y: geometry.size.height / 2
                        )
                }
            }
            
            // Temperature and data
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(day.high)°")
                        .font(.system(size: 64, weight: .light))
                    Text("/")
                        .font(.system(size: 32))
                        .opacity(0.5)
                        .padding(.horizontal, 4)
                    Text("\(day.low)°")
                        .font(.system(size: 48))
                        .opacity(0.7)
                }
                
                // Weather parameters
                VStack(spacing: 12) {
                    ParameterRowView(icon: "sun.max", label: "Condition", value: day.condition.displayName)
                    ParameterRowView(icon: "cloud.rain", label: "Precipitation", value: "\(Int.random(in: 0...60))%")
                    ParameterRowView(icon: "wind", label: "Wind", value: "\(Int.random(in: 10...25)) km/h")
                    ParameterRowView(icon: "humidity", label: "Humidity", value: "\(Int.random(in: 50...80))%")
                    ParameterRowView(icon: "sun.max", label: "UV Index", value: "\(Int.random(in: 1...8))")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
            
            
            
            Spacer()
            
        }
        .padding(.top, 80)
        .edgesIgnoringSafeArea(.top)
        .foregroundColor(day.condition.textColor)
        .background(day.condition.backgroundColor)
    }
}
