//
//  WeatherRepositoryEdgeTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherRepositoryEdgeTests: XCTestCase {
    
    private final class MockLocationService: LocationServiceProtocol {
        func getCurrentLocation() async throws -> LocationCoordinate {
            return LocationCoordinate(latitude: 0, longitude: 0)
        }
    }
    
    private final class MockAPIService: APIServiceProtocol {
        let response: WeatherResponseDTO
        init(response: WeatherResponseDTO) { self.response = response }
        func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable, T : Encodable {
            return response as! T
        }
    }
    
    func test_getDailyForecasts_whenLessThanRequiredDays_returnsAvailableDaysOnly() async throws {
        // Given only 2 distinct days in response
        let now = Date()
        let cal = Calendar.current
        let d1 = now
        let d2 = cal.date(byAdding: .day, value: 1, to: now)!
        
        let f1 = WeatherForecastDTO(main: MainDTO(temp: 10, tempMin: nil, tempMax: nil, humidity: nil),
                                    weather: [WeatherInfoDTO(main: "Clear", description: "", icon: "")],
                                    dtTxt: DateFormatters.apiFormatter.string(from: d1))
        let f2 = WeatherForecastDTO(main: MainDTO(temp: 11, tempMin: nil, tempMax: nil, humidity: nil),
                                    weather: [WeatherInfoDTO(main: "Clouds", description: "", icon: "")],
                                    dtTxt: DateFormatters.apiFormatter.string(from: d2))
        let response = WeatherResponseDTO(list: [f1, f2], city: nil)
        let repo = WeatherRepository(apiService: MockAPIService(response: response), locationService: MockLocationService())
        
        // When
        let result = try await repo.fetchWeatherForecast()
        
        // Then
        XCTAssertEqual(result.count, 2)
    }
}
