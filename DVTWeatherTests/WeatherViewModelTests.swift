//
//  WeatherViewModelTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherViewModelTests: XCTestCase {

    final class SuccessUseCase: WeatherUseCaseProtocol {
        let result: [Weather]
        init(result: [Weather]) { self.result = result }
        func getFiveDayForecast() async throws -> [Weather] { result }
    }

    final class FailureUseCase: WeatherUseCaseProtocol {
        let error: Error
        init(error: Error) { self.error = error }
        func getFiveDayForecast() async throws -> [Weather] { throw error }
    }

    func test_loadWeather_GivenValidData_WhenLoaded_ThenForecastsArePopulatedAndNoError() async {
        // Given
        let sampleWeather = Weather(temperature: 25, condition: .sunny, day: "Today", date: Date(), fullDate: "Monday")

        let viewModel: WeatherViewModel = await MainActor.run {
            WeatherViewModel(weatherUseCase: SuccessUseCase(result: [sampleWeather]))
        }

        // When
        await viewModel.loadWeather()

        // Then
        let isLoading = await viewModel.isLoading
        let hasData = await viewModel.hasData
        let error = await viewModel.error
        let forecastsCount = await viewModel.forecasts.count
        let currentCondition = await viewModel.currentWeatherCondition

        XCTAssertFalse(isLoading)
        XCTAssertTrue(hasData)
        XCTAssertNil(error)
        XCTAssertEqual(forecastsCount, 1)
        
        XCTAssertEqual(currentCondition, .sunny)
    }

    func test_loadWeather_GivenNetworkError_WhenLoaded_ThenSetsFriendlyErrorMessage() async {
        // Given
        let viewModel: WeatherViewModel = await MainActor.run {
            WeatherViewModel(weatherUseCase: FailureUseCase(error: NetworkError.invalidResponse))
        }

        // When
        await viewModel.loadWeather()

        // Then
        let isLoading = await viewModel.isLoading
        let errorMessage = await viewModel.error
        let hasData = await viewModel.hasData

        XCTAssertFalse(isLoading)
        XCTAssertEqual(errorMessage, LocalizedString.errorWeatherServiceUnavailable)
        XCTAssertFalse(hasData)
    }
}
