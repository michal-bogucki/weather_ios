//
//  Elements.swift
//  Weather application_
//
//  Created by Michał Bogucki on 03/04/2025.
//

import SwiftUICore
import SwiftUI

struct TitleApp: View {
    let location : WeatherLocation
    func isDarkBackground(_ category: VisualWeatherCategory) -> Bool {
        switch category {
        case .sunny, .lightSnow, .moderateSnow, .partlyCloudy, .icePellets:
            return false // Jasne tła
        default:
            return true  // Ciemne tła
        }
    }
    
    var body: some View {
        ZStack {
            // Neumorficzne tło
            RoundedRectangle(cornerRadius: 16)
                .fill(location.condition.backgroundColor)
                // Dostosowane cienie w zależności od jasności tła
                .shadow(color: isDarkBackground(location.condition.visualCategory)
                    ? Color.black.opacity(0.9)  // Mocniejszy cień dla ciemnych teł
                    : Color.black.opacity(0.25), // Delikatniejszy cień dla jasnych teł
                    radius: 12, x: 10, y: 10)
                // Jasny cień - dostosowany do typu tła
                .shadow(color: isDarkBackground(location.condition.visualCategory)
                    ? Color.white.opacity(0.2)  // Mniej widoczny biały cień dla ciemnych teł
                    : Color.white.opacity(0.8), // Mocniejszy biały cień dla jasnych teł
                    radius: 12, x: -10, y: -10)
                // Dodatkowy cień u dołu dla większego efektu głębi
                .shadow(color: isDarkBackground(location.condition.visualCategory)
                    ? Color.black.opacity(0.4)  // Mocniejszy dla ciemnych teł
                    : Color.black.opacity(0.15), // Delikatniejszy dla jasnych teł
                    radius: 16, x: 0, y: 12)
                // Dodatkowy wewnętrzny cień dla efektu wypukłości
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    isDarkBackground(location.condition.visualCategory)
                                        ? Color.white.opacity(0.5) // Jaśniejszy gradient dla ciemnych teł
                                        : Color.white.opacity(0.8), // Standardowy gradient dla jasnych teł
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: isDarkBackground(location.condition.visualCategory) ? 2 : 3
                        )
                )
            
            // Dostosowany wewnętrzny prostokąt
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            isDarkBackground(location.condition.visualCategory)
                                ? Color.white.opacity(0.1) // Jaśniejsza obwódka dla ciemnych teł
                                : Color.black.opacity(0.05), // Ciemniejsza dla jasnych teł
                            lineWidth: 1
                        )
                )
                .shadow(color: isDarkBackground(location.condition.visualCategory)
                    ? Color.black.opacity(0.15)
                    : Color.black.opacity(0.08),
                    radius: 3, x: 2, y: 2)
                .padding(4)
            
            VStack(spacing: 2) {
                // Rozrzucone litery z nieoczywistym fontem
                HStack(spacing: 2) {
                    // W - niżej
                    Text("W")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: 3)
                        .rotationEffect(Angle(degrees: -3))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    
                    // e - wyżej
                    Text("e")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(Color.red.opacity(0.6))
                        .offset(y: -3)
                        .rotationEffect(Angle(degrees: -8))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    Text("e")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: -1)
                        .rotationEffect(Angle(degrees: 6))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    
                    Text("t")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: -4)
                        .rotationEffect(Angle(degrees: 3))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    
                    Text("h")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: 3)
                        .rotationEffect(Angle(degrees: -2))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    
                    Text("e")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(Color.red.opacity(0.6))
                        .offset(y: -3)
                        .rotationEffect(Angle(degrees: -10))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    Text("e")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: -1)
                        .rotationEffect(Angle(degrees: 12))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                    
                    Text("r")
                        .font(.custom("AmericanTypewriter", size: 30))
                        .foregroundColor(location.condition.textColor)
                        .offset(y: 2)
                        .rotationEffect(Angle(degrees: -2))
                        .shadow(color: isDarkBackground(location.condition.visualCategory)
                            ? Color.black.opacity(0.3)
                            : Color.black.opacity(0.15),
                            radius: 1, x: 1, y: 1)
                }
                
                // Czerwone podkreślenie
                Capsule()
                    .fill(Color.red.opacity(0.6))
                    .frame(height: 3)
                    .offset(y: 2)
                    .padding(.horizontal, 2)
                    .shadow(color: isDarkBackground(location.condition.visualCategory)
                        ? Color.black.opacity(0.5)
                        : Color.black.opacity(0.3),
                        radius: 2, x: 1, y: 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .frame(width: 180, height: 60)
    }
    
}


struct ShowMoreButton: View {
    let textColor: Color
    let backgroundColor: Color
    let showMore: Bool
    let action: () -> Void
    var body: some View{
        Button(action: {
            withAnimation(.easeInOut(duration: 0.25)) {
                action()
            }
        }) {
            HStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        textColor.opacity(0),
                        textColor.opacity(0.4),
                        textColor.opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
        
                Image(systemName: showMore ? "minus" : "plus")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(textColor)
                    .frame(width: 36, height: 36) // Nieco większy rozmiar dla lepszego efektu
                    .background(
                        ZStack {
                            // Podstawowe wypukłe tło
                            Circle()
                                .fill(backgroundColor)
                                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 3, y: 3)
                                .shadow(color: Color.white.opacity(0.4), radius: 4, x: -3, y: -3)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 6)
                            
                            // Efekt wypukłości - wewnętrzny pierścień
                            Circle()
                                .fill(backgroundColor)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.white.opacity(0.5),
                                                    Color.white.opacity(0.0)
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                )
                            
                            // Dodatkowy efekt wypukłości
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.4),
                                            Color.white.opacity(0.0)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        }
                    )
                
                // Linia z gradientem (zachowana z oryginalnego przycisku)
                LinearGradient(
                    gradient: Gradient(colors: [
                        textColor.opacity(0),
                        textColor.opacity(0.4),
                        textColor.opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
            }
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 20)
    }
    
}
    
    
    
    
    
    
    
struct SearchButton: View {
    let textColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    var body : some View {
        Button(action: { action() }) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(textColor)
                .frame(width: 50, height: 50)
                .background(
                    ZStack {

                        Circle()
                            .fill(backgroundColor)
                            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.4), radius: 6, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 8) // Dodatkowy cień u dołu
                        
                       
                        Circle()
                            .fill(backgroundColor)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.white.opacity(0.5),
                                                Color.white.opacity(0.0)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2.5
                                    )
                            )
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.4),
                                        Color.white.opacity(0.0)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    }
                )
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 16)
    }
}
