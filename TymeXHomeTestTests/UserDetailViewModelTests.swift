//
//  UserDetailViewModelTests.swift
//  TymeXHomeTestTests
//
//  Created by Vu Thanh Do on 14/1/25.
//

import XCTest
@testable import TymeXHomeTest

final class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testGetUserDetail_Success() async {
        // Prepare mock user detail
        mockService.mockUserDetail = User(
            id: 1,
            login: "testuser",
            avatarUrl: "https://avatars.githubusercontent.com/u/8839147?s=400&v=4",
            htmlUrl: "https://github.com/vuthanhdo",
            location: "Nam Tu Liem, Ha Noi",
            followers: 101,
            following: 11
        )
        
        // Initialize view model
        viewModel = UserDetailViewModel(username: "testuser", service: mockService)
        
        let expectation = XCTestExpectation(description: "Fetch user detail")
        
        // Trigger API call
        viewModel.getUserDetail {
            XCTAssertEqual(self.viewModel.userDetail?.login, "testuser", "User login should match the mock data.")
            XCTAssertEqual(self.viewModel.userDetail?.followers, 101, "User followers should match the mock data.")
            XCTAssertFalse(self.viewModel.isLoading, "Loading should stop after data is fetched.")
            XCTAssertNil(self.viewModel.errorMessage, "Error message should be nil on success.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetUserDetail_Failure() {
        // Simulate error
        mockService.shouldThrowError = true
        mockService.mockError = .networkError(NSError(domain: "TestError", code: 1, userInfo: nil))
        
        // Initialize view model
        viewModel = UserDetailViewModel(username: "invaliduser", service: mockService)
        
        let expectation = XCTestExpectation(description: "Handle error")
        
        // Trigger API call
        viewModel.getUserDetail {
            XCTAssertTrue(self.viewModel.showAlert, "Alert should be shown when there is an error.")
            XCTAssertEqual(
                self.viewModel.errorMessage,
                "The operation couldn’t be completed. (TymeXHomeTest.APIError error 1.)",
                "Error message should match the simulated network error."
            )
            XCTAssertFalse(self.viewModel.isLoading, "Loading should stop on failure.")
            XCTAssertNil(self.viewModel.userDetail, "User detail should be nil on failure.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    
}
