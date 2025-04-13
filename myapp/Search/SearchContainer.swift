import SwiftUI

struct SearchContainer: View {
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack{
                Button(action: {presenter.didTapBack.send()}){
                    HStack{
                        Image(systemName: "chevron.left").frame(width: 16,height: 16)
                        Text("Back").font(.system(size: 20,weight: .light))
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .padding(16)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex: "5D87FF"))
                    .padding(.leading, 8)
                TextField("Search for a city...", text: $presenter.searchText)
                    .padding(.vertical,12)
                    .foregroundColor(Color(hex: "333333"))
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            Text("Recent Searches")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "333333"))
                .padding(.top, 24)
                .padding(.horizontal)
                .padding(.bottom, 12)
            
            ScrollView{
                ForEach(Array(presenter.recentLocations.enumerated()), id: \.element.id) { index, loc in
                    Button(action: {presenter.didSelectCity.send(loc) }){
                        HStack {
                            VStack(alignment: .leading) {
                                Text(loc.name)
                                    .font(.system(size:16,weight: .medium))
                                    .foregroundColor(Color(hex: "333333"))
                                
                                Text(loc.country)
                                    .font(.system(size:14,weight: .medium))
                                    .foregroundColor(Color(hex: "666666"))
                            }
                            Spacer()
                            HStack(spacing: 8) {
                                MiniWeatherArtView(condition: loc.condition, size: 24)
                                    .frame(width: 24, height: 24)
                                
                                Text("\(loc.temp)°")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(Color(hex: "333333"))
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
            }.padding(.bottom,24)
        }
        .padding(.top,50)
        
        .background(Color(hex: "F5F5F5"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    let input = SearchPresenter.Input(
        locationService: LocationService.shared
    )
    let presenter = SearchPresenter(input: input)
    return SearchContainer(presenter: presenter)
}

// MARK: - Search Header
struct SearchHeader: View {
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        HStack {
            Button(action: { presenter.didTapBack.send() }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                    
                    Text("Search Location")
                        .font(.system(size: 20, weight: .light))
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .padding(20)
        .padding(.top, 50) .foregroundColor(Color.black)
    }
}

// MARK: - Search Bar
struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("5D87FF"))
                .padding(.leading, 8)
            
            TextField("Search for a city...", text: $searchText)
                .padding(.vertical, 12)
                .foregroundColor(Color("333333"))
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

// MARK: - Recent Searches Section
struct RecentSearchesSection: View {
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Recent Searches")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("333333"))
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            ForEach(Array(presenter.recentLocations.enumerated()), id: \.element.id) { index, loc in
                RecentLocationRow(location: loc) {
                    presenter.didSelectCity.send(WeatherViewModelMapper.mapToLocation(from: sample1))
                }
            }
        }
    }
}

struct RecentLocationRow: View {
    let location: WeatherLocation
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("333333"))
                    Text(location.country)
                        .font(.system(size: 14))
                        .foregroundColor(Color("666666"))
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    // Commented out as in original code
                    // MiniWeatherArtView(condition: location.condition, size: 24)
                    //     .frame(width: 24, height: 24)
                    
                    Text("\(location.temp)°")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color("333333"))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Popular Cities Section
struct PopularCitiesSection: View {
    @ObservedObject var presenter: SearchPresenter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Cities")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("333333"))
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            popularCitiesGrid
        }
        .padding(.horizontal)
    }
    
    private var popularCitiesGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(["Paris", "London", "New York", "Tokyo", "Sydney", "Dubai"], id: \.self) { city in
                popularCityButton(for: city)
            }
        }
    }
    
    private func popularCityButton(for city: String) -> some View {
        Button(action: {
            if let location = presenter.recentLocations.first(where: { $0.name == city }) {
                presenter.didSelectCity.send(location)
            } else if let location = sampleData.first(where: { $0.name == city }) {
                presenter.didSelectCity.send(location)
            }
            
        }) {
            Text(city)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .foregroundColor(Color("5D87FF"))
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
