//
//  ForecastItem.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/04/2025.
//

import SwiftUI
import Combine

struct ForecastItem: View {
    let day: DailyForecast
    let isExpanded: Bool
    let onTap: () -> Void
    let onViewDetails: () -> Void
    let textColor: Color
    
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: onTap){
                HStack(spacing: 10) {
                    VStack(alignment: .leading,spacing: 4) {
                        Text(day.day)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(textColor)
                            
                        Text(day.condition.displayName)
                            .font(.system(size: 14,weight: .regular))
                            .foregroundStyle(textColor.opacity(0.6))
                    }
                    Spacer()
                    VStack(alignment: .trailing,spacing: 2) {
                        Text("HIGH")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(textColor.opacity(0.6))
                            .padding(.bottom, 2)
                        Text("\(day.high)°")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(textColor)
                    }
                    VStack(alignment: .trailing,spacing: 2) {
                        Text("LOW")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(textColor.opacity(0.6))
            
                        Text("\(day.low)°")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(textColor)
                    }
                   
                    
                    WeatherArtView(condition: day.condition, size: 30)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName:  isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(textColor.opacity(0.6))
                        .frame(width: 14, height: 14)
                    
                        
                
                }
                .padding(16)
                .background(Color.white.opacity(0.2))
                .cornerRadius(16, corners : isExpanded ? [.topLeft, .topRight] : .allCorners)
                
                
            }
            .buttonStyle(PlainButtonStyle())
            if isExpanded {
                VStack(spacing: 15){
                    HStack(spacing: 0) {
                        DayMetricItem(
                            icon: "cloud.rain",
                            title: "PRECIPITATION",
                            value: "\(Int.random(in: 5...60))%",
                            textColor: textColor
                        )
                        
                        DayMetricItem(
                            icon: "wind",
                            title: "WIND",
                            value: "\(Int.random(in: 5...25)) km/h",
                            textColor: textColor
                        )
                        
                        DayMetricItem(
                            icon: "sun.max",
                            title: "UV INDEX",
                            value: "\(Int.random(in: 1...10))",
                            textColor: textColor
                        )
                    }

                    
                    Button(action: onViewDetails) {
                        Text("View Full Details")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(day.condition.accentGradient)
                            .cornerRadius(12)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }
                .padding(.horizontal, 15)
                .background(Color.white.opacity(0.2))
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                .transition(.opacity)
            }
            
        }
    }
  
}



#Preview {
    let days = sampleData[0].weeklyForecast[0]
    return ForecastItem(
        day: days,
        isExpanded: true,
        onTap: { },
        onViewDetails: {},
        textColor: Color(hex: "333333")
    ).background(Color(hex: "f1ece1"))
}
