//
//  UserBlogView.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import SwiftUI

/// A subview for displaying the user's blog link.
struct UserBlogView: View {
    let blogUrl: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Blog")
                .padding(.horizontal)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Adapts to light/dark mode
            Text(blogUrl ?? "No blog available")
                .padding(.horizontal)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    UserBlogView(blogUrl: "https://github.com/vuthanhdo")
}
