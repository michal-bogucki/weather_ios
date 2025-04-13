import SwiftUI

// MARK: - Weather Art Views

struct WeatherArtView: View {
    let condition: WeatherConditionIcon
    let size: CGFloat
    
    var body: some View {
        ZStack {
            switch condition.visualCategory {
            case .sunny:
                // Red circle with horizontal line
                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: size, height: size)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: size/2, height: 1)
                        .offset(x: size/4)
                }
                
            case .clear:
                // Night sky with moon
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size * 0.8, height: size * 0.8)
                    
                    Circle()
                        .fill(condition.backgroundColor)
                        .frame(width: size * 0.7, height: size * 0.7)
                        .offset(x: -size/10)
                    
                    // Stars
                    ForEach(0..<8) { i in
                        Circle()
                            .fill(Color.white)
                            .frame(width: 3, height: 3)
                            .offset(
                                x: CGFloat.random(in: -size/2...size/2),
                                y: CGFloat.random(in: -size/2...size/2)
                            )
                    }
                }
                
            case .partlyCloudy:
                // Sun with cloud
                ZStack {
                    // Sun peeking out
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: size * 0.7, height: size * 0.7)
                        .offset(x: -size/5, y: -size/6)
                    
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size, height: size/2)
                        .offset(y: size/6)
                }
                
            case .cloudy:
                // Multiple clouds
                ZStack {
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.9, height: size/2)
                        .offset(x: size/8, y: -size/6)
                    
                    CloudShape()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size, height: size/2)
                        .offset(y: size/8)
                }
                
            case .foggy:
                // Horizontal lines for fog
                VStack(spacing: size/15) {
                    ForEach(0..<5) { i in
                        Rectangle()
                            .fill(Color.white.opacity(0.9 - Double(i) * 0.15))
                            .frame(width: size - CGFloat(i) * 10, height: 3)
                            .cornerRadius(1.5)
                    }
                }
                
            case .lightRain:
                // Few rain drops
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Rain drops
                    ForEach(0..<5) { i in
                        RainDrop(length: size/8)
                            .stroke(Color.blue.opacity(0.6), lineWidth: 2)
                            .offset(
                                x: size/6 - CGFloat(i) * size/6,
                                y: size/4 + (i % 2 == 0 ? size/10 : 0)
                            )
                    }
                }
                
            case .moderateRain:
                // More rain drops
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Rain drops
                    ForEach(0..<10) { i in
                        RainDrop(length: size/7)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                            .offset(
                                x: size/2 - CGFloat(i) * size/10,
                                y: size/4 + CGFloat(i % 3) * size/10
                            )
                    }
                }
                
            case .heavyRain:
                // Heavy rain
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Dense rain
                    ForEach(0..<20) { i in
                        RainDrop(length: size/6)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                            .offset(
                                x: size/2 - CGFloat(i % 7) * size/8,
                                y: size/5 + CGFloat(i % 4) * size/8
                            )
                    }
                }
                
            case .freezingRain:
                // Ice rain
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Ice drops
                    ForEach(0..<8) { i in
                        RainDrop(length: size/8)
                            .stroke(Color.cyan.opacity(0.8), lineWidth: 2)
                            .offset(
                                x: size/2 - CGFloat(i) * size/8,
                                y: size/4 + CGFloat(i % 3) * size/10
                            )
                    }
                    
                    // Ice crystals at bottom
                    ForEach(0..<4) { i in
                        SnowflakeSimple()
                            .stroke(Color.cyan.opacity(0.8), lineWidth: 1)
                            .frame(width: size/10, height: size/10)
                            .offset(
                                x: size/3 - CGFloat(i) * size/6,
                                y: size/2
                            )
                    }
                }
                
            case .lightSnow:
                // Light snowfall
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white)
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Snowflakes
                    ForEach(0..<6) { i in
                        SnowflakeSimple()
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: size/12, height: size/12)
                            .offset(
                                x: size/3 - CGFloat(i) * size/8,
                                y: size/6 + CGFloat(i % 3) * size/8
                            )
                    }
                }
                
            case .moderateSnow:
                // More snow
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Snowflakes
                    ForEach(0..<12) { i in
                        SnowflakeSimple()
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: size/15, height: size/15)
                            .offset(
                                x: size/2 - CGFloat(i % 5) * size/6,
                                y: size/6 + CGFloat(i % 4) * size/8
                            )
                    }
                }
                
            case .heavySnow:
                // Blizzard
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.gray.opacity(0.8))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Dense snowflakes
                    ForEach(0..<20) { i in
                        if i % 2 == 0 {
                            SnowflakeComplex()
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: size/12, height: size/12)
                                .offset(
                                    x: size/2 - CGFloat(i % 7) * size/7,
                                    y: CGFloat(i % 6) * size/8
                                )
                        } else {
                            SnowflakeSimple()
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: size/15, height: size/15)
                                .offset(
                                    x: size/2 - CGFloat(i % 5) * size/6,
                                    y: CGFloat(i % 5) * size/7
                                )
                        }
                    }
                }
                
            case .sleet:
                // Mixed rain and snow
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Rain drops
                    ForEach(0..<5) { i in
                        RainDrop(length: size/10)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                            .offset(
                                x: size/3 - CGFloat(i) * size/8,
                                y: size/6 + CGFloat(i % 2) * size/10
                            )
                    }
                    
                    // Snowflakes
                    ForEach(0..<5) { i in
                        SnowflakeSimple()
                            .stroke(Color.white, lineWidth: 1)
                            .frame(width: size/15, height: size/15)
                            .offset(
                                x: size/2 - CGFloat(i) * size/7,
                                y: size/4 + CGFloat(i % 3) * size/10
                            )
                    }
                }
                
            case .icePellets:
                // Ice pellets
                ZStack {
                    // Cloud
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Ice pellets
                    ForEach(0..<12) { i in
                        Circle()
                            .stroke(Color.cyan.opacity(0.8), lineWidth: 1)
                            .frame(width: size/20, height: size/20)
                            .offset(
                                x: size/2 - CGFloat(i % 5) * size/6,
                                y: size/4 + CGFloat(i % 4) * size/8
                            )
                    }
                }
                
            case .thunderstorm:
                // Lightning with rain
                ZStack {
                    // Dark cloud
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Lightning bolt
                    LightningBolt()
                        .fill(Color.yellow)
                        .frame(width: size/3, height: size/2)
                        .offset(y: size/8)
                    
                    // Rain drops
                    ForEach(0..<8) { i in
                        RainDrop(length: size/8)
                            .stroke(Color.blue.opacity(0.6), lineWidth: 1.5)
                            .offset(
                                x: size/3 - CGFloat(i) * size/8,
                                y: size/6 + CGFloat(i % 2) * size/8
                            )
                    }
                }
                
            case .thundersnow:
                // Lightning with snow
                ZStack {
                    // Dark cloud
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                        .offset(y: -size/6)
                    
                    // Lightning bolt
                    LightningBolt()
                        .fill(Color.yellow)
                        .frame(width: size/3, height: size/2)
                        .offset(y: size/8)
                    
                    // Snowflakes
                    ForEach(0..<6) { i in
                        SnowflakeSimple()
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: size/15, height: size/15)
                            .offset(
                                x: size/2 - CGFloat(i % 3) * size/4,
                                y: size/3 + CGFloat(i % 2) * size/6
                            )
                    }
                }
            }
        }
    }
}

// Mini version of weather art for the forecast days
struct MiniWeatherArtView: View {
    let condition: WeatherConditionIcon
    let size: CGFloat
    
    var body: some View {
        ZStack {
            switch condition.visualCategory {
            case .sunny:
                Circle()
                    .fill(Color.red)
                    .frame(width: size, height: size)
            
            case .clear:
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: size, height: size)
                    
                    Circle()
                        .fill(condition.backgroundColor)
                        .frame(width: size * 0.8, height: size * 0.8)
                        .offset(x: -size/10)
                }
                
            case .partlyCloudy:
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: size * 0.6, height: size * 0.6)
                        .offset(x: -size/5, y: -size/10)
                    
                    CloudShape()
                        .fill(Color.white)
                        .frame(width: size, height: size/2)
                        .offset(y: size/10)
                }
                
            case .cloudy:
                CloudShape()
                    .fill(Color.gray.opacity(0.7))
                    .frame(width: size, height: size/2)
                
            case .foggy:
                VStack(spacing: 2) {
                    ForEach(0..<3) { i in
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: size, height: 1)
                    }
                }
                
            case .lightRain, .moderateRain:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                    
                    // Single rain drop
                    RainDrop(length: size/3)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        .frame(width: size/4)
                        .offset(y: size/4)
                }
                
            case .heavyRain:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Multiple rain drops
                    RainDrop(length: size/3)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        .frame(width: size/5)
                        .offset(x: -size/6, y: size/4)
                    
                    RainDrop(length: size/3)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        .frame(width: size/5)
                        .offset(x: size/6, y: size/4)
                }
                
            case .freezingRain:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Ice drop
                    RainDrop(length: size/3)
                        .stroke(Color.cyan.opacity(0.7), lineWidth: 1)
                        .frame(width: size/4)
                        .offset(y: size/4)
                }
                
            case .lightSnow, .moderateSnow:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size, height: size/2)
                    
                    // Snowflake
                    SnowflakeSimple()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: size/3, height: size/3)
                        .offset(y: size/4)
                }
                
            case .heavySnow:
                ZStack {
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Multiple snowflakes
                    SnowflakeSimple()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: size/4, height: size/4)
                        .offset(x: -size/6, y: size/4)
                    
                    SnowflakeSimple()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: size/4, height: size/4)
                        .offset(x: size/6, y: size/4)
                }
                
            case .sleet:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Rain and snow
                    RainDrop(length: size/3)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        .frame(width: size/5)
                        .offset(x: -size/6, y: size/4)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: size/5, height: size/5)
                        .offset(x: size/6, y: size/4)
                }
                
            case .icePellets:
                ZStack {
                    CloudShape()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Ice pellets
                    Circle()
                        .stroke(Color.cyan.opacity(0.7), lineWidth: 1)
                        .frame(width: size/5, height: size/5)
                        .offset(y: size/4)
                }
                
            case .thunderstorm:
                ZStack {
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Lightning
                    LightningBolt()
                        .fill(Color.yellow)
                        .frame(width: size/2, height: size/2)
                        .offset(y: size/6)
                }
                
            case .thundersnow:
                ZStack {
                    CloudShape()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size, height: size/2)
                    
                    // Lightning
                    LightningBolt()
                        .fill(Color.yellow)
                        .frame(width: size/3, height: size/3)
                        .offset(x: -size/10, y: size/6)
                    
                    // Snow
                    Circle()
                        .fill(Color.white)
                        .frame(width: size/6, height: size/6)
                        .offset(x: size/6, y: size/4)
                }
            }
        }
    }
}





// MARK: - MiniWeatherArtView All Cases Preview
#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 30) {
            Text("MiniWeatherArtView - All Cases")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                // Clear / Sunny
                WeatherCategoryPreview(title: "Sunny", condition: .sunny, mini: true)
                WeatherCategoryPreview(title: "Clear", condition: .clear, mini: true)
                
                // Cloudy variations
                WeatherCategoryPreview(title: "Partly Cloudy", condition: .partlyCloudy, mini: true)
                WeatherCategoryPreview(title: "Cloudy", condition: .cloudy, mini: true)
                WeatherCategoryPreview(title: "Overcast", condition: .overcast, mini: true)
                
                // Mist and fog
                WeatherCategoryPreview(title: "Mist", condition: .mist, mini: true)
                WeatherCategoryPreview(title: "Fog", condition: .fog, mini: true)
                WeatherCategoryPreview(title: "Freezing Fog", condition: .freezingFog, mini: true)
                
                // Rain variations
                WeatherCategoryPreview(title: "Patchy Rain", condition: .patchyRainPossible, mini: true)
                WeatherCategoryPreview(title: "Light Drizzle", condition: .lightDrizzle, mini: true)
                WeatherCategoryPreview(title: "Mod. Rain", condition: .moderateRain, mini: true)
                WeatherCategoryPreview(title: "Heavy Rain", condition: .heavyRain, mini: true)
                
                // Snow variations
                WeatherCategoryPreview(title: "Light Snow", condition: .lightSnow, mini: true)
                WeatherCategoryPreview(title: "Mod. Snow", condition: .moderateSnow, mini: true)
                WeatherCategoryPreview(title: "Heavy Snow", condition: .heavySnow, mini: true)
                WeatherCategoryPreview(title: "Blizzard", condition: .blizzard, mini: true)
                
                // Mixed conditions
                WeatherCategoryPreview(title: "Sleet", condition: .lightSleet, mini: true)
                WeatherCategoryPreview(title: "Ice Pellets", condition: .icePellets, mini: true)
                
                // Thunder variations
                WeatherCategoryPreview(title: "Thunder", condition: .thunderyOutbreaksPossible, mini: true)
                WeatherCategoryPreview(title: "Thunderstorm", condition: .moderateOrHeavyRainWithThunder, mini: true)
                WeatherCategoryPreview(title: "Snow & Thunder", condition: .moderateOrHeavySnowWithThunder, mini: true)
            }
            .padding(.horizontal)
        }
    }
    .background(Color(hex: "F5F5F5"))
}

// MARK: - WeatherArtView All Cases Preview
#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 30) {
            Text("WeatherArtView - All Cases")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 30) {
                // Clear / Sunny
                WeatherCategoryPreview(title: "Sunny", condition: .sunny, mini: false)
                WeatherCategoryPreview(title: "Clear", condition: .clear, mini: false)
                
                // Cloudy variations
                WeatherCategoryPreview(title: "Partly Cloudy", condition: .partlyCloudy, mini: false)
                WeatherCategoryPreview(title: "Cloudy", condition: .cloudy, mini: false)
                WeatherCategoryPreview(title: "Overcast", condition: .overcast, mini: false)
                
                // Mist and fog
                WeatherCategoryPreview(title: "Mist", condition: .mist, mini: false)
                WeatherCategoryPreview(title: "Fog", condition: .fog, mini: false)
                WeatherCategoryPreview(title: "Freezing Fog", condition: .freezingFog, mini: false)
                
                // Rain variations
                WeatherCategoryPreview(title: "Patchy Rain", condition: .patchyRainPossible, mini: false)
                WeatherCategoryPreview(title: "Light Drizzle", condition: .lightDrizzle, mini: false)
                WeatherCategoryPreview(title: "Moderate Rain", condition: .moderateRain, mini: false)
                WeatherCategoryPreview(title: "Heavy Rain", condition: .heavyRain, mini: false)
                
                // Snow variations
                WeatherCategoryPreview(title: "Light Snow", condition: .lightSnow, mini: false)
                WeatherCategoryPreview(title: "Moderate Snow", condition: .moderateSnow, mini: false)
                WeatherCategoryPreview(title: "Heavy Snow", condition: .heavySnow, mini: false)
                WeatherCategoryPreview(title: "Blizzard", condition: .blizzard, mini: false)
                
                // Mixed conditions
                WeatherCategoryPreview(title: "Sleet", condition: .lightSleet, mini: false)
                WeatherCategoryPreview(title: "Ice Pellets", condition: .icePellets, mini: false)
                
                // Thunder variations
                WeatherCategoryPreview(title: "Thunder", condition: .thunderyOutbreaksPossible, mini: false)
                WeatherCategoryPreview(title: "Thunderstorm", condition: .moderateOrHeavyRainWithThunder, mini: false)
                WeatherCategoryPreview(title: "Snow & Thunder", condition: .moderateOrHeavySnowWithThunder, mini: false)
            }
            .padding(.horizontal)
        }
    }
    .background(Color(hex: "F5F5F5"))
}


// Helper Views for Previews
struct WeatherCategoryPreview: View {
    let title: String
    let condition: WeatherConditionIcon
    let mini: Bool
    
    var body: some View {
        VStack {
            if mini {
                MiniWeatherArtView(condition: condition, size: 36)
                    .frame(width: 36, height: 36)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(condition.backgroundColor.opacity(0.3))
                    )
            } else {
                WeatherArtView(condition: condition, size: 80)
                    .frame(width: 80, height: 80)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(condition.backgroundColor.opacity(0.3))
                    )
            }
            
            Text(title)
                .font(.system(size: mini ? 12 : 14))
                .multilineTextAlignment(.center)
                .frame(height: mini ? 30 : 40)
        }
        .frame(maxWidth: .infinity)
    }
}


