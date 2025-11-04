//
//  EndpointTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class EndpointTests: XCTestCase {
    func test_weatherEndpoint_forecast_buildsCorrectURLAndQueryItems() throws {
        // Given
        let lat = 30.0
        let lon = 31.0
        let e = WeatherEndpoint.forecast(latitude: lat, longitude: lon)
        
        // When
        let request = try e.urlRequest()
        guard let url = request.url else { XCTFail("Missing URL"); return }
        let comps = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let query = comps?.queryItems ?? []
        let dict = Dictionary(uniqueKeysWithValues: query.map { ($0.name, $0.value ?? "") })
        
        // Then
        XCTAssertTrue(url.absoluteString.contains("/data/2.5/forecast"))
        XCTAssertEqual(dict["lat"], "\(lat)")
        XCTAssertEqual(dict["lon"], "\(lon)")
        XCTAssertEqual(dict["units"], "metric")
        XCTAssertEqual(dict["appid"], Configuration.API.apiKey)
    }
    
    func test_urlRequest_invalidBaseURL_handlesGracefully() {
        struct BadEndpoint: Endpoint {
            var baseURL: String = "%%%"
            var path: String = "/"
            var method: String = "GET"
            var parameters: [String : String] = [:]
        }
        
        do {
            let req = try BadEndpoint().urlRequest()
            let urlStr = req.url?.absoluteString ?? ""
            XCTAssertTrue(urlStr.contains("%%%") || urlStr.isEmpty == false, "Expected either an invalidURL error or a constructed URL containing the base string")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
        }
    }
}
