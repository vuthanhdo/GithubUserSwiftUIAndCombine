//
//  Test.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 15/1/25.
//

import SwiftUI
/// A subview for displaying user stats such as followers and following.
struct UserStatsView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center) {
            StatItemView(
                iconName: "person.2.fill",
                statValue: user.getFollower(),
                statLabel: "Follower"
            )
            StatItemView(
                iconName: "medal.fill",
                statValue: user.getFollowing(),
                statLabel: "Following"
            )
        }
        .padding()
    }
}

#Preview {
    let user = User(
        id: 1,
        login: "test username",
        avatarUrl: "https://avatars.githubusercontent.com/u/8839147?s=400&v=4",
        htmlUrl: "https://github.com/vuthanhdo",
        location: "Nam Tu Liem, Ha Noi",
        followers: 101,
        following: 11
    )
    UserStatsView(user: user)
}


