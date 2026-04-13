//
//  UserListView.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 13/1/25.
//

import SwiftUI

/// A view that displays a list of GitHub users fetched from the API.
/// The list supports infinite scrolling and navigation to detailed user information.
struct UserListView: View {
    /// The view model responsible for managing user data and API calls.
    @StateObject private var viewModel = UserListViewModel(service: UserService())
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.users) { user in
                        if let username = user.login {
                            let userDetailViewModel = UserDetailViewModel(username: username, service: UserService())
                            NavigationLink(destination: UserDetailView(viewModel: userDetailViewModel)) {
                                UserCardView(user: user, showLocation: false, showHtmlLink: true)
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView("Loading more...")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else if viewModel.canLoadMore {
                        Color.clear
                            .frame(height: 1)
                            .onAppear {
                                viewModel.loadMoreItems()
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("GitHub Users")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear() {
            if viewModel.users.isEmpty {
                viewModel.loadMoreItems()
            }
        }
    }
}
