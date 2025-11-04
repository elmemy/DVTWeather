//
//  WeatherUseCaseTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherUseCaseTests: XCTestCase {

    final class MockRepository: WeatherRepositoryProtocol {
        var dtos: [WeatherForecastDTO]
        init(dtos: [WeatherForecastDTO]) { self.dtos = dtos }
        func fetchWeatherForecast() async throws -> [WeatherForecastDTO] { dtos }
    }

    func test_getFiveDayForecast_GivenDTOs_WhenMapped_ThenReturnsDomainObjects() async throws {
        // Given
        let now = Date()
        func dto(_ offset: Int, _ temp: Double, _ main: String) -> WeatherForecastDTO {
            WeatherForecastDTO(
                main: MainDTO(temp: temp, tempMin: nil, tempMax: nil, humidity: nil),
                weather: [WeatherInfoDTO(main: main, description: "", icon: "")],
                dtTxt: DateFormatters.apiFormatter.string(from: Calendar.current.date(byAdding: .day, value: offset, to: now)!)
            )
        }

        let repository = MockRepository(dtos: [dto(0, 10.6, "Clear"), dto(1, 11.3, "Clouds"), dto(2, 12.9, "Rain")])
        let useCase = WeatherUseCase(repository: repository)

        // When
        let weathers = try await useCase.getFiveDayForecast()

        // Then
        XCTAssertEqual(weathers.count, 3)
        XCTAssertEqual(weathers[0].condition, .sunny)
        XCTAssertEqual(weathers[1].condition, .cloudy)
        XCTAssertEqual(weathers[2].condition, .rainy)
    }
}
