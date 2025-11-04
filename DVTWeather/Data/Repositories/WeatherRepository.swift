//
//  WeatherRepository.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeatherForecast() async throws -> [WeatherForecastDTO]
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private let locationService: LocationServiceProtocol
    
    init(apiService: APIServiceProtocol, locationService: LocationServiceProtocol) {
        self.apiService = apiService
        self.locationService = locationService
    }
    
    func fetchWeatherForecast() async throws -> [WeatherForecastDTO] {
        let location = try await locationService.getCurrentLocation()
        let response: WeatherResponseDTO = try await apiService.request(
            endpoint: WeatherEndpoint.forecast(
                latitude: location.latitude,
                longitude: location.longitude
            )
        )
        
        return getDailyForecasts(from: response.list)
    }
    
    private func getDailyForecasts(from forecasts: [WeatherForecastDTO]) -> [WeatherForecastDTO] {
        let groupedByDay = Dictionary(grouping: forecasts) { forecast -> String in
            guard let date = DateFormatters.apiFormatter.date(from: forecast.dtTxt) else { return "" }
            return DateFormatters.dateOnlyFormatter.string(from: date)
        }
        
        let bestForecasts = groupedByDay.compactMap { (_, dayForecasts) -> WeatherForecastDTO? in
            return dayForecasts.max { f1, f2 in
                return f1.main.temp < f2.main.temp
            }
        }
        
        return bestForecasts
            .sorted {
                guard let date1 = DateFormatters.apiFormatter.date(from: $0.dtTxt),
                      let date2 = DateFormatters.apiFormatter.date(from: $1.dtTxt) else {
                    return false
                }
                return date1 < date2
            }
            .prefix(Configuration.Weather.forecastDays)
            .map { $0 }
    }
}
