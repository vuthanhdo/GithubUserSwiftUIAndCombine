//
//  UserCardView.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 13/1/25.
//

import SwiftUI
import NukeUI

struct UserCardView: View {
    let user: User
    let showLocation: Bool
    let showHtmlLink: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Use Nuke for cached image loading
            LazyImage(url: URL(string: user.avatarUrl ?? "")) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if state.error != nil {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.secondary) // Adapts to light/dark mode
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground)) // Dynamic background color
                    .frame(width: 80, height: 90)
            )
            
            VStack(alignment: .leading) {
                Text(user.login ?? "")
                    .font(.title3)
                    .foregroundColor(.primary) // Adapts to light/dark mode
                    .fontWeight(.bold)
                Divider()
                if showHtmlLink {
                    Text(user.htmlUrl ?? "")
                        .font(.body)
                        .foregroundColor(.blue)
                        .underline()
                }
                if showLocation {
                    HStack {
                        Image(systemName: "location")
                            .font(.body)
                            .foregroundColor(.secondary) // Adapts to light/dark mode
                        Text(user.location ?? "")
                            .font(.body)
                            .foregroundColor(.secondary) // Adapts to light/dark mode
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground)) // Dynamic card background color
        .cornerRadius(16)
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5) // Adapts shadow to light/dark mode
        .padding(.horizontal, 16)
    }
}

#Preview {
    Group {
        UserCardView(
            user: User(
                id: 1,
                login: "test username",
                avatarUrl: "https://avatars.githubusercontent.com/u/8839147?s=400&v=4",
                htmlUrl: "https://github.com/vuthanhdo",
                location: "Nam Tu Liem, Ha Noi",
                followers: 101,
                following: 11
            ),
            showLocation: true,
            showHtmlLink: false
        )
        
        UserCardView(
            user: User(
                id: 1,
                login: "test username",
                avatarUrl: "https://avatars.githubusercontent.com/u/8839147?s=400&v=4",
                htmlUrl: "https://github.com/vuthanhdo",
                location: "Nam Tu Liem, Ha Noi",
                followers: 101,
                following: 11
            ),
            showLocation: false,
            showHtmlLink: true
        )
    }
    .preferredColorScheme(.dark) // Preview in dark mode
}
