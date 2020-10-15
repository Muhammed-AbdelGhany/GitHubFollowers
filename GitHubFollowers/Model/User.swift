//
//  User.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/23/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation

struct User: Codable {
    let login :String
    var name :String?
    let avatarUrl :String
    var location :String?
    var bio :String?
    let publicRepos :Int
    let publicGists : Int
    let htmlUrl :String
    let following :Int
    let followers :Int
    let createdAt :String
    
}
