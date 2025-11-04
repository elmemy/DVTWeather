//
//  Localization.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import Foundation

// MARK: - Localization
struct LocalizedString {
    // MARK: - General
    static let loadingWeather = NSLocalizedString("loading_weather", comment: "Loading weather text")
    static let fiveDayForecast = NSLocalizedString("five_day_forecast", comment: "5 day forecast title")
    static let unableToLoad = NSLocalizedString("unable_to_load", comment: "Unable to load error title")
    static let tryAgain = NSLocalizedString("try_again", comment: "Try again button")
    static let noWeatherData = NSLocalizedString("no_weather_data", comment: "No weather data title")
    static let pullToRefresh = NSLocalizedString("pull_to_refresh", comment: "Pull to refresh instruction")
    static let today = NSLocalizedString("today", comment: "Label for today's date")
    static let tomorrow = NSLocalizedString("tomorrow", comment: "Label for tomorrow's date")

    // MARK: - Network Errors
    static let errorInvalidURL = NSLocalizedString("error_invalid_url", comment: "Invalid URL error")
    static let errorInvalidResponse = NSLocalizedString("error_invalid_response", comment: "Invalid server response error")
    static let errorDecodingFailed = NSLocalizedString("error_decoding_failed", comment: "Failed to decode response error")

    // MARK: - Location Errors
    static let errorLocationNotAuthorized = NSLocalizedString("error_location_not_authorized", comment: "Location access not authorized error")

    // MARK: - User-Friendly Weather Messages
    static let errorWeatherServiceUnreachable = NSLocalizedString("error_weather_service_unreachable", comment: "Weather service unreachable message")
    static let errorWeatherServiceUnavailable = NSLocalizedString("error_weather_service_unavailable", comment: "Weather service unavailable message")
    static let errorWeatherDataUnprocessable = NSLocalizedString("error_weather_data_unprocessable", comment: "Weather data unprocessable message")
    static let errorWeatherGeneric = NSLocalizedString("error_weather_generic", comment: "Generic weather loading error")
}
