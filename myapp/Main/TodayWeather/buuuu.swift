//
//  buuuu.swift
//  Weather application_
//
//  Created by Michał Bogucki on 02/04/2025.
//
import SwiftUI

struct bbb: View{
    let location: WeatherLocation
    let showMore: Binding<Bool>
    var body:some View{
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                showMore.toggle()
            }
        }) {
            ZStack {
                // Tło z gradientem dopasowanym do pogody
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                location.condition.textColor.opacity(0.1),
                                location.condition.textColor.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        // Dodaj dynamiczny element związany z pogodą
                        Group {
                            if ["sunny", "clear"].contains(location.condition.rawValue) {
                                // Słońce/gwiazdy dla słonecznej/bezchmurnej pogody
                                Circle()
                                    .fill(location.condition.textColor.opacity(0.3))
                                    .frame(width: 16, height: 16)
                                    .offset(x: showMore ? 50 : -50, y: 0)
                            } else if ["cloudy", "partlyCloudy"].contains(location.condition.visualCategory.rawValue) {
                                // Chmura dla pochmurnej pogody
                                CloudShape()
                                    .fill(location.condition.textColor.opacity(0.3))
                                    .frame(width: 32, height: 16)
                                    .offset(x: showMore ? 50 : -50, y: 0)
                            } else if ["lightRain", "moderateRain", "heavyRain"].contains(location.condition.visualCategory.rawValue) {
                                // Kropla deszczu
                                RainDrop(length: 16)
                                    .stroke(location.condition.textColor.opacity(0.3), lineWidth: 2)
                                    .frame(width: 10, height: 16)
                                    .offset(x: showMore ? 50 : -50, y: 0)
                            } else if ["lightSnow", "moderateSnow", "heavySnow"].contains(location.condition.visualCategory.rawValue) {
                                // Płatek śniegu
                                SnowflakeSimple()
                                    .stroke(location.condition.textColor.opacity(0.3), lineWidth: 1)
                                    .frame(width: 16, height: 16)
                                    .offset(x: showMore ? 50 : -50, y: 0)
                            }
                        }
                    )
                
                // Treść przycisku
                HStack {
                    Image(systemName: showMore ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(location.condition.textColor)
                    
                    Text(showMore ? "Hide details" : "More details")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(location.condition.textColor)
                }
                .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(location.condition.textColor.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.top, 16)
    }
}
