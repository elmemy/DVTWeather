//
//  WeatherUseCase.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

protocol WeatherUseCaseProtocol {
    func getFiveDayForecast() async throws -> [Weather]
}

final class WeatherUseCase: WeatherUseCaseProtocol {
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFiveDayForecast() async throws -> [Weather] {
        let forecasts = try await repository.fetchWeatherForecast()
        return forecasts.map { $0.toDomain() }
    }
}
