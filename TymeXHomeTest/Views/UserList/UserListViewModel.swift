//
//  UserListViewModel.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 13/1/25.
//

import Foundation

/// A view model responsible for fetching and managing a list of GitHub users.
class UserListViewModel: ObservableObject {
    /// The list of GitHub users.
    @Published var users: [User] = [] {
        didSet {
            CacheManager.shared.save(users, to: "userList")
        }
    }
    
    /// Indicates whether data is currently being loaded.
    @Published var isLoading = false
    
    /// An error message, if an error occurs during data loading.
    var errorMessage: String?
    
    /// Whether an alert should be shown for an error.
    @Published var showAlert = false
    
    /// Tracks the last user ID fetched for pagination.
    private var since = 100
    
    /// Able continue fetching for pagination
    var canLoadMore = true
    
    /// session, able to inhect to mock session for unit test.
    private var service: UserServiceInterface
    
    // custom init allowing us to inject a mock session during testing
    init(service: UserServiceInterface) {
        self.service = service
        loadUsersFromCache()
    }
    
    func loadMoreItems(completion: (() -> Void)? = nil) {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        errorMessage = nil
        showAlert = false
        
        Task { @MainActor in
            do {
                let users = try await service.getListUser(perPage: Constants.perPage, since: self.since)
                self.users.append(contentsOf: users)
                self.isLoading = false
                self.since += users.count
                self.canLoadMore = users.count == Constants.perPage
                completion?()
            } catch {
                self.errorMessage = error.localizedDescription
                self.showAlert = true
                self.isLoading = false
                completion?()
            }
        }
    }
    
    private func loadUsersFromCache() {
        if let cachedUsers: [User] = CacheManager.shared.load(from: "userList", as: [User].self) {
            self.users = cachedUsers
        }
    }
}
