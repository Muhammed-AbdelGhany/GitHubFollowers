//
//  User.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/23/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation

struct User: Codable {
    var login :String
    var name :String?
    var avatarUrl :String
    var location :String?
    var bio :String?
    var publicRepos :Int
    var publicGists : Int
    var htmlUrl :String
    var following :Int
    var followers :Int
    var createdAt :String
    
}
