//
//  WeatherConditionTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class WeatherConditionTests: XCTestCase {
    func test_iconAndBackground_forEachCase_returnsNonEmptyStrings() {
        let all: [WeatherCondition] = [.sunny, .cloudy, .rainy, .snowy, .partlyCloudy, .thunderstorm, .foggy, .windy]
        for cond in all {
            XCTAssertFalse(cond.iconName.isEmpty, "iconName should not be empty for \(cond)")
            XCTAssertFalse(cond.backgroundImageName.isEmpty, "backgroundImageName should not be empty for \(cond)")
        }
    }
    
    func test_weatherMapping_fromDTOStrings() {
        let mapper = { (s: String?) -> WeatherCondition in
            let dto = WeatherForecastDTO(main: MainDTO(temp: 10, tempMin: nil, tempMax: nil, humidity: nil),
                                         weather: s == nil ? [] : [WeatherInfoDTO(main: s ?? "", description: "", icon: "")],
                                         dtTxt: DateFormatters.apiFormatter.string(from: Date()))
            return dto.toDomain().condition
        }
        
        XCTAssertEqual(mapper("Clear"), .sunny)
        XCTAssertEqual(mapper("clear"), .sunny)
        XCTAssertEqual(mapper("Clouds"), .cloudy)
        XCTAssertEqual(mapper("rain"), .rainy)
        XCTAssertEqual(mapper("drizzle"), .rainy)
        XCTAssertEqual(mapper("thunderstorm"), .rainy)
        XCTAssertEqual(mapper("Snow"), .snowy)
        XCTAssertEqual(mapper(nil), .sunny)
        XCTAssertEqual(mapper("unexpected"), .sunny)
    }
}
