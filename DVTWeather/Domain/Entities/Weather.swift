//
//  Weather.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import Foundation
import SwiftUI

struct Weather: Identifiable {
    let id = UUID()
    let temperature: Int
    let condition: WeatherCondition
    let day: String
    let date: Date
    let fullDate: String
    
    var accessibilityLabel: String {
        "\(day), \(temperature) degrees, \(condition.rawValue)"
    }
}

enum WeatherCondition: String {
    case sunny
    case cloudy
    case rainy
    case snowy
    case partlyCloudy
    case thunderstorm
    case foggy
    case windy
    
    var backgroundImageName: String {
        switch self {
        case .sunny: return "Sunny"
        case .cloudy, .partlyCloudy: return "Cloudy"
        case .rainy, .thunderstorm: return "Rainy"
        case .snowy: return "Forest"
        case .foggy: return "Forest"
        case .windy: return "Forest"
        }
    }
    
    var iconName: String {
        switch self {
        case .sunny: return "01.sun-light"
        case .cloudy, .partlyCloudy: return "02.sunset-light"
        case .rainy, .thunderstorm: return "03.sunrise-light"
        case .snowy: return "02.sunset-light"
        case .foggy: return "02.sunset-light"
        case .windy: return "02.sunset-light" 
        }
    }
}
