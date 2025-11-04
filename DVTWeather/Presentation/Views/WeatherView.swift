//
//  WeatherView.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import SwiftUI

// MARK: - Main Weather View
struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            backgroundImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            contentView
        }
        .task {
            await viewModel.loadWeather()
        }
        .refreshable {
            await viewModel.loadWeather()
        }
    }
    
    private var backgroundImage: Image {
        guard let currentWeather = viewModel.currentWeather else {
            return Image("Forest")
        }
        
        return Image(currentWeather.condition.backgroundImageName)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            LoadingView()
        } else if let error = viewModel.error {
            ErrorView(error: error, onRetry: {
                Task { await viewModel.loadWeather() }
            })
        } else if viewModel.hasData {
            ForecastListView(forecasts: viewModel.forecasts)
        } else {
            EmptyView()
        }
    }
}



