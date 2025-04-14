//
//  ForecastScreenContainer.swift
//  Weather application_
//
//  Created by Michał Bogucki on 04/04/2025.
//

import SwiftUICore
import SwiftUI
import Combine

struct ForecastScreenContainer: View {
    @ObservedObject var presenter: ForecastWeatherPresenter
    
    
    @State private var selectedForecastIndex: Int? = nil
    
    
    var body: some View {
        let location = presenter.selectedLocation
        var gradientBackground: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors: [
                    location.condition.backgroundColor.opacity(0.9),
                    location.condition.backgroundColor.opacity(1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
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

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("6-DAY FORECAST")
                            .font(.system(size: 14, weight: .semibold))
                            .tracking(1)
                            .foregroundColor(location.condition.textColor.opacity(0.9))
                        
                        Spacer()
                        
                        HStack(spacing: 5) {
                            Image(systemName: "calendar")
                                .font(.system(size: 12))
                            Text("Daily")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(location.condition.textColor.opacity(0.7))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                  ScrollView {

                            ForEach(Array(location.weeklyForecast.enumerated()), id: \.element.id) { index, day in
                                ForecastItem(
                                    day: day,
                                    isExpanded: selectedForecastIndex == index,
                                    onTap: {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            if selectedForecastIndex == index {
                                                selectedForecastIndex = nil
                                            } else {
                                                selectedForecastIndex = index
                                            }
                                        }
                                    },
                                    onViewDetails: {
                                        presenter.didTapOpenDetails.send(day)
                                    },
                                    textColor: location.condition.textColor
                                )
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            }

                    }
                }
            
        }
        .padding(.top, 80)
        .edgesIgnoringSafeArea(.top)
        .foregroundColor(location.condition.textColor)
        .background(location.condition.backgroundColor)
    }
}


#Preview {
    let locationSelectedInput = PassthroughSubject<WeatherLocation, Never>()
    
    let input = ForecastWeatherPresenter.Input(
        locationSelectedInput: locationSelectedInput,
        locationService: LocationService.shared
    )
    
    let presenter = ForecastWeatherPresenter(input: input)
    
    locationSelectedInput.send(sampleData[5])
    
    return ForecastScreenContainer(
        presenter: presenter
    )
}
