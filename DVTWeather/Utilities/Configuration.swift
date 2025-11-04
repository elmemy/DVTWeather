//
//  Configuration.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import Foundation
import CoreGraphics
import UIKit

enum Configuration {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    enum API {
        static var baseURL: String {
            guard let openWeatherDict = infoDictionary["OpenWeatherAPI"] as? [String: Any],
                  let url = openWeatherDict["BaseURL"] as? String else {
                return ""
            }
            return url
        }
        
        static var apiKey: String {
            guard let openWeatherDict = infoDictionary["OpenWeatherAPI"] as? [String: Any],
                  let key = openWeatherDict["APIKey"] as? String else {
                return ""
            }
            return key
        }
    }
    
    enum Weather {
        static let forecastDays = 5
    }
    
    enum UI {
        static let cardCornerRadius: CGFloat = 16
        static let horizontalPadding: CGFloat = 25
        static let gridSpacing: CGFloat = 16
        static let cardHeight: CGFloat = 120
        static let iconSize: CGFloat = 70
        static let dividerHeight: CGFloat = 1
        
        // Shadow properties
        static let shadowOpacity: Double = 0.2
        static let shadowRadius: CGFloat = 2
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 1
        
        // Frame widths
        static let dayTextWidth: CGFloat = 100
        static let temperatureTextWidth: CGFloat = 80
        
        // Border properties
        static let borderOpacity: Double = 0.3
        static let borderLineWidth: CGFloat = 1
        
        // Image sizes
        static let smallIconSize: CGFloat = 50
    }
    
    enum Layout {
        static let titleTopPadding: CGFloat = 60
        static let sectionSpacing: CGFloat = 32
        static let forecastHeaderFrame: CGFloat = 28
        static let cardContentSpacing: CGFloat = 20
        static let cardVerticalPadding: CGFloat = 16
        static let errorHorizontalPadding: CGFloat = 32
    }
    
    enum FontSize {
        static let title: CGFloat = 18
        static let subtitle: CGFloat = 16
        static let largeTitle: CGFloat = 22
        static let weatherCard: CGFloat = 16
        static let weatherTemperature: CGFloat = 36
        
        // Line heights
        static let titleLineHeight: CGFloat = 28
        static let weatherCardLineHeight: CGFloat = 24
        static let weatherTemperatureLineHeight: CGFloat = 44
    }
    
    enum Animation {
        static let shortDuration: Double = 0.3
        static let mediumDuration: Double = 0.5
        static let longDuration: Double = 1.0
    }
    
    // Progress view scale effect
    enum Progress {
        static let scaleEffect: Double = 1.5
    }
}
