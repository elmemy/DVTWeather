//
//  WeatherRepositoryTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherRepositoryTests: XCTestCase {

    // MARK: - Mocks
    private final class MockLocationService: LocationServiceProtocol {
        func getCurrentLocation() async throws -> LocationCoordinate {
            return LocationCoordinate(latitude: 10, longitude: 20)
        }
    }

    private final class MockAPIService: APIServiceProtocol {
        var response: WeatherResponseDTO
        init(response: WeatherResponseDTO) { self.response = response }
        func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable, T : Encodable {
            return response as! T
        }
    }

    // MARK: - Tests
    func test_fetchWeatherForecast_GivenMultipleTimesPerDay_WhenFetched_ThenSelectsClosestToNoonAndSorted() async throws {
        // Given
        let baseDate = Date()
        var forecasts: [WeatherForecastDTO] = []
        let calendar = Calendar.current

        for dayOffset in 0..<6 {
            let day = calendar.date(byAdding: .day, value: dayOffset, to: baseDate)!
            let morning = calendar.date(bySettingHour: 3, minute: 0, second: 0, of: day)!
            let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: day)!

            forecasts.append(
                WeatherForecastDTO(
                    main: MainDTO(temp: Double(10 + dayOffset), tempMin: nil, tempMax: nil, humidity: nil),
                    weather: [WeatherInfoDTO(main: "Clear", description: "", icon: "")],
                    dtTxt: DateFormatters.apiFormatter.string(from: morning)
                )
            )

            forecasts.append(
                WeatherForecastDTO(
                    main: MainDTO(temp: Double(20 + dayOffset), tempMin: nil, tempMax: nil, humidity: nil),
                    weather: [WeatherInfoDTO(main: "Rain", description: "", icon: "")],
                    dtTxt: DateFormatters.apiFormatter.string(from: noon)
                )
            )
        }

        let response = WeatherResponseDTO(list: forecasts, city: nil)
        let repository = WeatherRepository(
            apiService: MockAPIService(response: response),
            locationService: MockLocationService()
        )

        // When
        let result = try await repository.fetchWeatherForecast()

        // Then
        XCTAssertEqual(result.count, Configuration.Weather.forecastDays)
        let hours = result.compactMap {
            Calendar.current.component(.hour, from: DateFormatters.apiFormatter.date(from: $0.dtTxt)!)
        }
        XCTAssertTrue(hours.allSatisfy { abs($0 - 12) <= 3 }, "All selected hours should be near noon")
    }
}
