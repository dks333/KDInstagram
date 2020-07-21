//
//  User.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

struct User: Hashable {
    
    var profilePic : UIImage
    var username: String
    var description: String
    var name : String
    var followers : [User]
    var following : [User]
    var posts: [Post]
    var stories: [Story]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(username.hashValue)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
    
}

