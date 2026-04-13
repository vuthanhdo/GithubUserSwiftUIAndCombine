//
//  APIClient.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import Foundation

/// A generic API client for making network requests.
class APIClient {
    private let session: URLSession
    
    /// Initializes the API client with a URLSession.
    /// - Parameter session: The URLSession instance to use. Defaults to `.shared`.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Sends a request and decodes the response into the specified type.
    ///
    /// - Parameters:
    ///   - url: The URL to make the request to.
    ///   - method: The HTTP method (e.g., "GET", "POST").
    /// - Returns: The decoded object of the specified type.
    /// - Throws: An error if the request fails or decoding fails.
    func request<T: Decodable>(
        url: URL,
        method: String = "GET"
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}

/// Errors that can occur during API requests.
enum APIError: Error {
    case invalidResponse
    case decodingFailed(Error)
    case networkError(Error)
}
