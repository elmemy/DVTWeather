//
//  AppFont.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import SwiftUI

enum AppFont {
    case bold(size: CGFloat, lineHeight: CGFloat? = nil)
    case semiBold(size: CGFloat, lineHeight: CGFloat? = nil)
    case medium(size: CGFloat, lineHeight: CGFloat? = nil)
    case regular(size: CGFloat, lineHeight: CGFloat? = nil)
    
    var font: Font {
        switch self {
        case .bold(let size, _):
            return .custom("Poppins-Bold", size: size)
        case .semiBold(let size, _):
            return .custom("Poppins-SemiBold", size: size)
        case .medium(let size, _):
            return .custom("Poppins-Medium", size: size)
        case .regular(let size, _):
            return .custom("Poppins-Regular", size: size)
        }
    }
}

extension Font {
    static func poppins(_ type: AppFont) -> Font {
        return type.font
    }
    
    static let titleFont = poppins(.bold(size: Configuration.FontSize.title))
    static let weatherTemperature = poppins(.bold(size: Configuration.FontSize.weatherTemperature))
    static let weatherCardTitle = poppins(.semiBold(size: Configuration.FontSize.weatherCard))
}
