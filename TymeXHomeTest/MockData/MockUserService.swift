//
//  MockUserService.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import Foundation

class MockUserService: UserServiceInterface {
    var mockUserList: [User] = []
    var mockUserDetail: User?
    var shouldThrowError = false
    var mockError: APIError = .invalidResponse
    
    func getListUser(perPage: Int, since: Int) async throws -> [User] {
        if shouldThrowError { throw mockError }
        return mockUserList
    }
    
    func getUserDetail(username: String) async throws -> User {
        if shouldThrowError { throw mockError }
        guard let user = mockUserDetail else { throw APIError.invalidResponse }
        return user
    }
}
