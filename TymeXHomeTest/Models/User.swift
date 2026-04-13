//
//  User.swift
//  TymeXHomeTest
//
//  Created by Vu Thanh Do on 13/1/25.
//

import Foundation

struct User: Identifiable, Decodable, Encodable {
    let id: Int?
    let login: String?
    let avatarUrl: String?
    let htmlUrl: String?
    let location: String?
    let followers: Int?
    let following: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case location
        case followers
        case following
    }
    
    public init(
        id: Int?,
        login: String?,
        avatarUrl: String?,
        htmlUrl: String?,
        location: String?,
        followers: Int?,
        following: Int?
    ) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.location = location
        self.followers = followers
        self.following = following
    }
    
    func getFollower() -> String {
        guard let followers else { return "" }
        if followers > Constants.maxFollowerNumber {
            return "\(Constants.maxFollowerNumber)+"
        }
        return "\(followers)"
    }
    
    func getFollowing() -> String {
        guard let following else { return ""}
        if following > Constants.maxFollowingNumber {
            return "\(Constants.maxFollowingNumber)+"
        }
        return "\(following)"
    }
}
