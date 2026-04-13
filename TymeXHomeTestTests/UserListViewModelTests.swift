//
//  UserListViewModelTests.swift
//  TymeXHomeTestTests
//
//  Created by Vu Thanh Do on 14/1/25.
//

import XCTest
@testable import TymeXHomeTest

final class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        viewModel = UserListViewModel(service: mockService)
        CacheManager.shared.clearCache()
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        CacheManager.shared.clearCache()
        super.tearDown()
    }
    
    func testLoadMoreItems_Failure() {
        // Simulate error
        mockService.mockUserList = []
        viewModel.users = []
        mockService.shouldThrowError = true
        mockService.mockError = .networkError(NSError(domain: "TestError", code: 1, userInfo: nil))
        
        let expectation = XCTestExpectation(description: "Handle error")
        
        // Trigger load
        viewModel.loadMoreItems {
            XCTAssertTrue(self.viewModel.showAlert, "Alert should be shown when there is an error.")
            XCTAssertEqual(
                self.viewModel.errorMessage,
                "The operation couldn’t be completed. (TymeXHomeTest.APIError error 1.)",
                "Error message should match the simulated network error."
            )
            XCTAssertFalse(self.viewModel.isLoading, "Loading should stop on failure.")
            XCTAssertTrue(self.viewModel.users.isEmpty, "Users list should remain empty on failure.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testLoadMoreItems_Success() {
        // Prepare mock data
        mockService.mockUserList = (1...20).map {
            User(
                id: $0,
                login: "user\($0)",
                avatarUrl: "https://avatars.githubusercontent.com/u/\($0)?s=400&v=4",
                htmlUrl: "https://github.com/user\($0)",
                location: "Location \($0)",
                followers: $0 * 10,
                following: $0
            )
        }
        
        let expectation = XCTestExpectation(description: "Load more items")
        
        // Trigger load
        viewModel.loadMoreItems {
            XCTAssertEqual(self.viewModel.users.count, 20, "User count should match the mock data.")
            XCTAssertTrue(self.viewModel.canLoadMore, "Should allow loading more users.")
            XCTAssertFalse(self.viewModel.isLoading, "Loading should stop after data is fetched.")
            XCTAssertNil(self.viewModel.errorMessage, "Error message should be nil on success.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    
    
}
