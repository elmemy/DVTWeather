//
//  LocationService.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import CoreLocation

protocol LocationServiceProtocol {
    func getCurrentLocation() async throws -> LocationCoordinate
}

struct LocationCoordinate {
    let latitude: Double
    let longitude: Double
}

final class LocationService: NSObject, LocationServiceProtocol {
    private let locationManager: CLLocationManager
    private var continuation: CheckedContinuation<LocationCoordinate, Error>?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentLocation() async throws -> LocationCoordinate {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                continuation.resume(throwing: LocationError.notAuthorized)
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        continuation?.resume(returning: LocationCoordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        ))
        continuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            continuation?.resume(throwing: LocationError.notAuthorized)
            continuation = nil
        default:
            break
        }
    }
}

enum LocationError: Error, LocalizedError {
    case notAuthorized
    
    var errorDescription: String? {
        switch self {
        case .notAuthorized: return LocalizedString.errorLocationNotAuthorized
        }
    }
}
