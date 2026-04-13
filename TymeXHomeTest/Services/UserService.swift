//
//  UserService.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import Foundation

/// A service for interacting with the GitHub API, conforming to `UserServiceProtocol`.
class UserService: UserServiceInterface {
    private let client: APIClient
    private let userPath = "users"
    
    /// Initializes the service with a specified API client.
    /// - Parameter client: The API client to use. Defaults to a new `APIClient` instance.
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    /// Fetches a paginated list of GitHub users.
    /// - Parameters:
    ///   - perPage: Number of users to fetch per page.
    ///   - since: The ID to start fetching from.
    /// - Returns: An array of `User` objects.
    /// - Throws: An error if the request fails.
    func getListUser(perPage: Int, since: Int) async throws -> [User] {
        guard let url = URL(string: "\(Constants.baseURL)\(userPath)?per_page=\(perPage)&since=\(since)") else {
            throw APIError.invalidResponse
        }
        return try await client.request(url: url)
    }
    
    /// Fetches the details of a GitHub user.
    /// - Parameter username: The username of the GitHub user.
    /// - Returns: The `User` object for the specified username.
    /// - Throws: An error if the request fails.
    func getUserDetail(username: String) async throws -> User {
        guard let url = URL(string: "\(Constants.baseURL)\(userPath)/\(username)") else {
            throw APIError.invalidResponse
        }
        return try await client.request(url: url)
    }
    
}
