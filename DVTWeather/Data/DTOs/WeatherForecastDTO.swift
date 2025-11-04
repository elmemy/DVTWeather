//
//  WeatherForecastDTO.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import Foundation

struct WeatherResponseDTO: Codable {
    let list: [WeatherForecastDTO]
    let city: CityDTO?
}

struct CityDTO: Codable {
    let name: String
    let country: String
}

struct WeatherForecastDTO: Codable {
    let main: MainDTO
    let weather: [WeatherInfoDTO]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main, weather
        case dtTxt = "dt_txt"
    }
    
    func toDomain() -> Weather {
        let date = DateFormatters.apiFormatter.date(from: dtTxt) ?? Date()
        let calendar = Calendar.current
        
        let displayDay: String
        if calendar.isDateInToday(date) {
            displayDay = LocalizedString.today
        } else if calendar.isDateInTomorrow(date) {
            displayDay = LocalizedString.tomorrow
        } else {
            displayDay = DateFormatters.fullDayFormatter.string(from: date)
        }
        
        let condition = determineWeatherCondition(from: weather.first?.main.lowercased())
        
        return Weather(
            temperature: Int(main.temp.rounded()),
            condition: condition,
            day: displayDay,
            date: date,
            fullDate: DateFormatters.dayFormatter.string(from: date)
        )
    }
    
    private func determineWeatherCondition(from weatherMain: String?) -> WeatherCondition {
        guard let weatherMain = weatherMain else { return .sunny }
        
        switch weatherMain {
        case "clear":
            return .sunny
        case "clouds":
            return .cloudy
        case "rain", "drizzle", "thunderstorm":
            return .rainy
        case "snow":
            return .snowy
        default:
            return .sunny
        }
    }
}

struct MainDTO: Codable {
    let temp: Double
    let tempMin: Double?
    let tempMax: Double?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct WeatherInfoDTO: Codable {
    let main: String
    let description: String
    let icon: String
}
