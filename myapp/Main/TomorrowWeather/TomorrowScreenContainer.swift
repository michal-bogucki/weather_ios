//
//  TomorrowScreenContainer.swift
//  Weather application_
//
//  Created by Michał Bogucki on 26/03/2025.
//

import SwiftUI
import Combine

struct TomorrowScreenContainer: View {
    @ObservedObject var presenter: TomorrowWeatherPresenter
    
    var body: some View {
        let location = presenter.selectedLocation
        
        ZStack {
            VStack {
                HStack {
                    TitleApp(location: location)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    SearchButton(
                        textColor: location.condition.textColor,
                        backgroundColor: location.condition.backgroundColor,
                        action: { presenter.didTapSearch.send() }
                    )
                    .frame(width: 50)
                    .padding(.horizontal,16)
                }
                
                ScrollView {
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 4){
                            Text(location.date)
                                .font(.system(size: 14))
                                .opacity(0.7)
                            Text(location.name)
                                .font(.system(size: 24, weight: .medium))
                            Text(location.country)
                                .font(.system(size: 14))
                                .opacity(0.7)
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical,12)
                        
                        ZStack {
                            WeatherArtView(condition: location.condition, size: 180)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                            
                            GeometryReader { geometry in
                                Text(location.condition.displayName)
                                    .font(.system(size: 32, weight: .light))
                                    .rotationEffect(.degrees(-90))
                                    .position(
                                        x: UIScreen.main.bounds.width - 20,
                                        y: geometry.size.height / 2
                                    )
                            }
                        }
                        
                        VStack(alignment : .leading, spacing: 16){
                            Text("\(location.temp)°")
                                .font(.system(size: 72, weight: .light))
                            
                            VStack(spacing: 12){
                                ParameterRowView(icon: "thermometer", label: "High / Low", value: "\(location.high)° / \(location.low)°")
                                ParameterRowView(icon: "cloud.rain", label: "Precipitation", value: "\(location.precipitation)%")
                                ParameterRowView(icon: "wind", label: "Wind", value: "\(location.wind) km/h")
                                ParameterRowView(icon: "humidity", label: "Humidity", value: "\(location.humidity)%")
                                ParameterRowView(icon: "sun.max", label: "UV Index", value: "\(location.uvIndex)")
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 32)

                    }.padding(.top, 8)
                    
                }
               
            }
            .padding(.top, 80)
            .edgesIgnoringSafeArea(.top)
            .foregroundColor(location.condition.textColor)
            .background(location.condition.backgroundColor)
        }
    }
}

#Preview {
    let locationSelectedInput = PassthroughSubject<WeatherLocation, Never>()
    
    let input = TomorrowWeatherPresenter.Input(
        locationSelectedInput: locationSelectedInput,
        locationService: LocationService.shared
    )
    
    let presenter = TomorrowWeatherPresenter(input: input)
    
    locationSelectedInput.send(sampleData[0])
    
    return TomorrowScreenContainer(presenter: presenter)
}
