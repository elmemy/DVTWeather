//
//  WeatherForecastDTOEdgeTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherForecastDTOEdgeTests: XCTestCase {
    
    func test_toDomain_dayLabelFormatting_forTodayTomorrowAndShortName() {
        // Given
        let now = Date()
        let calendar = Calendar.current
        let todayDTO = WeatherForecastDTO(
            main: MainDTO(temp: 12.4, tempMin: nil, tempMax: nil, humidity: nil),
            weather: [WeatherInfoDTO(main: "Clear", description: "", icon: "")],
            dtTxt: DateFormatters.apiFormatter.string(from: now)
        )
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        let tomorrowDTO = WeatherForecastDTO(
            main: MainDTO(temp: 13.4, tempMin: nil, tempMax: nil, humidity: nil),
            weather: [WeatherInfoDTO(main: "Clouds", description: "", icon: "")],
            dtTxt: DateFormatters.apiFormatter.string(from: tomorrow)
        )
        let later = calendar.date(byAdding: .day, value: 3, to: now)!
        let laterDTO = WeatherForecastDTO(
            main: MainDTO(temp: 5.0, tempMin: nil, tempMax: nil, humidity: nil),
            weather: [WeatherInfoDTO(main: "Snow", description: "", icon: "")],
            dtTxt: DateFormatters.apiFormatter.string(from: later)
        )
        
        // When
        let todayW = todayDTO.toDomain()
        let tomorrowW = tomorrowDTO.toDomain()
        let laterW = laterDTO.toDomain()
        
        // Then
        XCTAssertEqual(todayW.day, LocalizedString.today)
        XCTAssertEqual(tomorrowW.day, LocalizedString.tomorrow)
        XCTAssertFalse(laterW.day.isEmpty, "Day label should not be empty")
        XCTAssertNotEqual(laterW.day, LocalizedString.today)
        XCTAssertNotEqual(laterW.day, LocalizedString.tomorrow)
    }
    
    func test_toDomain_whenDtTxtInvalid_usesCurrentDate() {
        let dto = WeatherForecastDTO(
            main: MainDTO(temp: 8.0, tempMin: nil, tempMax: nil, humidity: nil),
            weather: [WeatherInfoDTO(main: "Clear", description: "", icon: "")],
            dtTxt: "invalid-date-format"
        )
        let domain = dto.toDomain()
        XCTAssertFalse(domain.fullDate.isEmpty)
    }
}
