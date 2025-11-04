//
//  DVTWeatherApp.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import SwiftUI

@main
struct DVTWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    weatherUseCase: WeatherUseCase(
                        repository: WeatherRepository(
                            apiService: APIService(),
                            locationService: LocationService()
                        )
                    )
                )
            )
        }
    }
}
