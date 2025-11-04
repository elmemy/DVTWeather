//
//  APIServiceTests.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import XCTest
@testable import DVTWeather

final class APIServiceTests: XCTestCase {
    
    final class StubURLProtocol: URLProtocol {
        static var responseData: Data?
        static var response: HTTPURLResponse?
        static var error: Error?
        
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            if let err = StubURLProtocol.error {
                client?.urlProtocol(self, didFailWithError: err)
            } else {
                if let resp = Self.response {
                    client?.urlProtocol(self, didReceive: resp, cacheStoragePolicy: .notAllowed)
                }
                if let data = Self.responseData {
                    client?.urlProtocol(self, didLoad: data)
                }
                client?.urlProtocolDidFinishLoading(self)
            }
        }
        override func stopLoading() {}
    }
    
    func makeService() -> APIService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        let session = URLSession(configuration: config)
        return APIService(session: session, decoder: JSONDecoder())
    }
    
    func test_request_WhenServerReturnsNon2xx_ThenThrowsInvalidResponse() async {
        // Given
        let service = makeService()
        StubURLProtocol.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        StubURLProtocol.responseData = Data()
        
        struct TestEndpoint: Endpoint {
            var baseURL: String = "https://example.com"
            var path: String = "/"
            var method: String = "GET"
            var parameters: [String : String] = [:]
        }
        
        // When / Then
        do {
            let _: WeatherResponseDTO = try await service.request(endpoint: TestEndpoint())
            XCTFail("Expected to throw invalidResponse, but succeeded")
        } catch {
            XCTAssertEqual((error as? NetworkError), NetworkError.invalidResponse)
        }
    }
    
    func test_request_WhenDataIsInvalidJSON_ThenThrowsDecodingError() async {
        // Given
        let service = makeService()
        StubURLProtocol.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        StubURLProtocol.responseData = "not json".data(using: .utf8)
        
        struct TestEndpoint: Endpoint {
            var baseURL: String = "https://example.com"
            var path: String = "/"
            var method: String = "GET"
            var parameters: [String : String] = [:]
        }
        
        // When / Then
        do {
            let _: WeatherResponseDTO = try await service.request(endpoint: TestEndpoint())
            XCTFail("Expected to throw decodingError, but succeeded")
        } catch {
            XCTAssertEqual((error as? NetworkError), NetworkError.decodingError)
        }
    }
}
