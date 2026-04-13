//
//  UserDetailViewModel.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 14/1/25.
//

import Foundation

/// A view model responsible for fetching and managing the details of a GitHub user.
///
/// This class uses `ObservableObject` to provide real-time updates to its published properties.
/// It performs an API call to fetch user details and handles errors gracefully.
class UserDetailViewModel: ObservableObject {
    // MARK: - Properties
    
    /// The username of the GitHub user whose details are being fetched.
    private let username: String
    
    /// The URLSession instance used to perform network requests.
    ///
    /// This is injected to facilitate testing by allowing the use of a mock session.
    private let service: UserServiceInterface
    
    /// The detailed information of the GitHub user.
    @Published var userDetail: User?
    
    /// Indicates whether the view model is currently fetching data.
    @Published var isLoading = false
    
    /// The error message in case of a failure during the API request.
    var errorMessage: String?
    
    /// Indicates whether an alert should be displayed to show the error message.
    @Published var showAlert = false
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `UserDetailViewModel` with the given username.
    ///
    /// - Parameters:
    ///   - username: The GitHub username whose details are to be fetched.
    ///   - session: The URLSession instance used for making network requests. Defaults to `.shared`.
    init(username: String, service: UserServiceInterface) {
        self.username = username
        self.service = service
    }
    
    // MARK: - Methods
    
    /// Fetches the details of the GitHub user from the API.
    ///
    /// This method makes an HTTP GET request to the GitHub API to retrieve user details.
    /// If the request is successful, the `userDetail` property is updated with the fetched data.
    /// If an error occurs, appropriate error messages are set, and `showAlert` is toggled.
    ///
    /// - Note: This method prevents multiple simultaneous requests by checking the `isLoading` flag.
    func getUserDetail(completion: (() -> Void)? = nil) {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        showAlert = false
        
        Task { @MainActor in
            do {
                let user = try await service.getUserDetail(username: username)
                self.userDetail = user
                self.isLoading = false
                completion?()
            } catch {
                self.errorMessage = error.localizedDescription
                self.showAlert = true
                self.isLoading = false
                completion?()
            }
        }
    }
}
