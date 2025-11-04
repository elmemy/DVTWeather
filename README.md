# DVTWeather

DVTWeather is an iOS weather application built using Swift and SwiftUI.  
It displays a five-day weather forecast based on the user’s current location and demonstrates clean architecture, localization, and unit testing.

---

## Overview

The app fetches real-time weather data from the OpenWeatherMap API and presents it using a simple and responsive SwiftUI interface.  
It follows the MVVM architecture and applies SOLID principles for maintainability and scalability.

---

## Features

- Displays current and five-day weather forecasts  
- Uses CoreLocation to detect the user’s location  
- Fetches data from OpenWeatherMap API  
- Handles network and decoding errors gracefully  
- Supports localization for all user-facing text  
- Includes unit tests for core components  

---

## Architecture

The project follows the MVVM (Model–View–ViewModel) pattern:

- **View:** SwiftUI interface displaying observable data  
- **ViewModel:** Handles data loading, formatting, and error management  
- **UseCase & Repository:** Manage business logic and API communication  
- **Services:** Handle API and location operations  

---

## Localization

All text is localized through `Localization.swift` and `Localizable.strings`.

Example:
```swift
Text(LocalizedString.noWeatherData)
