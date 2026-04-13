//
//  UserServiceInterface.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import Foundation

//// A protocol that defines the methods for fetching user data.
protocol UserServiceInterface {
    /// Fetches the details of a GitHub user.
    /// - Parameter username: The username of the GitHub user.
    /// - Returns: The `User` object for the specified username.
    /// - Throws: An error if the request fails.
    func getUserDetail(username: String) async throws -> User
    
    /// Fetches a paginated list of GitHub users.
    /// - Parameters:
    ///   - perPage: Number of users to fetch per page.
    ///   - since: The ID to start fetching from.
    /// - Returns: An array of `User` objects.
    /// - Throws: An error if the request fails.
    func getListUser(perPage: Int, since: Int) async throws -> [User]
}

