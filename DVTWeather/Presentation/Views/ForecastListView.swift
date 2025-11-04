//
//  ForecastListView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import SwiftUI

struct ForecastListView: View {
    let forecasts: [Weather]
    
    var body: some View {
        ScrollView {
            VStack(spacing: Configuration.Layout.sectionSpacing) {
                ForecastHeaderView()
                
                VStack(spacing: Configuration.UI.gridSpacing) {
                    ForEach(forecasts) { weather in
                        WeatherListItemView(weather: weather)
                    }
                }
                .padding(.horizontal, Configuration.UI.horizontalPadding)
            }
        }
    }
}
