//
//  WeatherViewModel.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var forecasts: [Weather] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    @Published private(set) var locationName: String = ""
    
    private let weatherUseCase: WeatherUseCaseProtocol
    
    init(weatherUseCase: WeatherUseCaseProtocol) {
        self.weatherUseCase = weatherUseCase
    }
    
    func loadWeather() async {
        isLoading = true
        error = nil
        
        do {
            forecasts = try await weatherUseCase.getFiveDayForecast()
        } catch {
            self.error = error.localizedDescription
            self.error = getFriendlyErrorMessage(from: error)
        }
        
        isLoading = false
    }
    
    var currentWeather: Weather? {
        forecasts.first
    }
    
    var currentWeatherCondition: WeatherCondition {
        forecasts.first?.condition ?? .sunny
    }
    
    var hasData: Bool {
        !forecasts.isEmpty && error == nil
    }
    
    private func getFriendlyErrorMessage(from error: Error) -> String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidURL:
                return LocalizedString.errorWeatherServiceUnreachable
            case .invalidResponse:
                return LocalizedString.errorWeatherServiceUnavailable
            case .decodingError:
                return LocalizedString.errorWeatherDataUnprocessable
            }
        } else if let locationError = error as? LocationError {
            return locationError.localizedDescription
        } else {
            return LocalizedString.errorWeatherGeneric
        }
    }
}
