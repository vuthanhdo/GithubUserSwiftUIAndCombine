//
//  UserDetailView.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 13/1/25.
//

import SwiftUI

/// A view that displays detailed information about a specific GitHub user.
struct UserDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UserDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                ProgressView("Loading more...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else if let user = viewModel.userDetail {
                UserCardView(user: user, showLocation: true, showHtmlLink: false)
                UserStatsView(user: user)
                UserBlogView(blogUrl: user.htmlUrl)
                Spacer()
            }
        }
        .background(Color(.systemBackground)) // Dynamic background color
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(dismissAction: dismiss)
            }
            ToolbarItem(placement: .principal) {
                Text("Users Detail")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary) // Adapts to light/dark mode
            }
        }
        .onAppear {
            viewModel.getUserDetail()
        }
    }
}
