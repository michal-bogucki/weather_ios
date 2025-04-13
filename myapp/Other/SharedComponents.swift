//
//  SharedComponents.swift
//  Weather application_
//
//  Created by Michał Bogucki on 02/04/2025.
//

import SwiftUI

// MARK: - Shared UI Components
// Contains reusable UI components shared across different screens


struct TabButton: View {
    let title: String
    let isActive: Bool
    let textColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16))
                    .opacity(isActive ? 1 : 0.7)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                
                Rectangle()
                    .fill(textColor)
                    .frame(height: 2)
                    .opacity(isActive ? 1 : 0)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Parameter row for displaying weather data
struct ParameterRowView: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .opacity(0.7)
                    .frame(width: 20)
                    .padding(.trailing, 8)
                
                Text(label)
                    .font(.system(size: 16))
                    .opacity(0.7)
            }
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
        }
    }
}

// Weather metric item for compact display
struct WeatherMetricItem: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.7))
            
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .tracking(0.5)
                .foregroundColor(.white.opacity(0.6))
            
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}

// Day metric item for forecast details
struct DayMetricItem: View {
    let icon: String
    let title: String
    let value: String
    let textColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(textColor.opacity(0.7))
            
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .tracking(0.5)
                .foregroundColor(textColor.opacity(0.6))
            
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity)
    }
}

// Weather insight card for detailed metrics
struct WeatherInsightCard: View {
    let title: String
    let value: String
    let description: String
    let icon: String
    let color: Color
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .tracking(0.5)
                    .foregroundColor(textColor.opacity(0.7))
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
            }
            
            // Content
            if !value.isEmpty {
                Text(value)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(textColor)
            }
            
            Text(description)
                .font(.system(size: 14, weight: value.isEmpty ? .semibold : .medium))
                .foregroundColor(textColor.opacity(value.isEmpty ? 0.9 : 0.7))
                .lineLimit(2)
            
            Spacer()
        }
        .padding(15)
        .frame(width: 160, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Material.ultraThinMaterial)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}
