//
//  WeatherForecastDTOTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import XCTest
@testable import DVTWeather

final class WeatherForecastDTOTests: XCTestCase {

    func test_toDomain_WhenTodayAndTomorrowAndShortDay_ThenReturnsProperDayLabelsAndConditions() {
        // Given
        let calendar = Calendar.current
        let now = Date()
        let today = now
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        let laterDay = calendar.date(byAdding: .day, value: 2, to: now)!

        func makeDTO(date: Date, temp: Double, main: String) -> WeatherForecastDTO {
            WeatherForecastDTO(
                main: MainDTO(temp: temp, tempMin: nil, tempMax: nil, humidity: nil),
                weather: [WeatherInfoDTO(main: main, description: "", icon: "")],
                dtTxt: DateFormatters.apiFormatter.string(from: date)
            )
        }

        let todayDTO = makeDTO(date: today, temp: 21.5, main: "Clear")
        let tomorrowDTO = makeDTO(date: tomorrow, temp: 14.7, main: "Rain")
        let laterDTO = makeDTO(date: laterDay, temp: -1.4, main: "Snow")

        // When
        let todayWeather = todayDTO.toDomain()
        let tomorrowWeather = tomorrowDTO.toDomain()
        let laterWeather = laterDTO.toDomain()

        // Then
        XCTAssertEqual(todayWeather.day, "Today")
        XCTAssertEqual(todayWeather.condition, .sunny)
        XCTAssertEqual(todayWeather.temperature, 22)

        XCTAssertEqual(tomorrowWeather.day, "Tomorrow")
        XCTAssertEqual(tomorrowWeather.condition, .rainy)

        XCTAssertFalse(laterWeather.day.isEmpty, "Day should not be empty")
        XCTAssertNotEqual(laterWeather.day, LocalizedString.today)
        XCTAssertNotEqual(laterWeather.day, LocalizedString.tomorrow)
        XCTAssertEqual(laterWeather.condition, .snowy)
    }

    func test_toDomain_GivenNoWeatherData_WhenConverted_ThenDefaultsToSunnyCondition() {
        // Given
        let dto = WeatherForecastDTO(
            main: MainDTO(temp: 10.0, tempMin: nil, tempMax: nil, humidity: nil),
            weather: [],
            dtTxt: DateFormatters.apiFormatter.string(from: Date())
        )

        // When
        let domain = dto.toDomain()

        // Then
        XCTAssertEqual(domain.condition, .sunny)
    }
}
