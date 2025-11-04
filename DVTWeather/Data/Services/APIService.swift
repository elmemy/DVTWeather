//
//  APIService.swift
//  DVTWeather
//
//  Created by Elmemy on 03/11/2025.
//

import Foundation

protocol APIServiceProtocol {
    func request<T: Codable>(endpoint: Endpoint) async throws -> T
}

final class APIService: APIServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Codable>(endpoint: Endpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [String: String] { get }
}

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}

enum WeatherEndpoint: Endpoint {
    case forecast(latitude: Double, longitude: Double)
    
    var baseURL: String { Configuration.API.baseURL }
    var path: String { "/data/2.5/forecast" }
    var method: String { "GET" }
    
    var parameters: [String: String] {
        switch self {
        case .forecast(let latitude, let longitude):
            return [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "appid": Configuration.API.apiKey,
                "units": "metric"
            ]
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return LocalizedString.errorInvalidURL
        case .invalidResponse: return LocalizedString.errorInvalidResponse
        case .decodingError: return LocalizedString.errorDecodingFailed
        }
    }
}
