//
//  Post.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    var user: User
    var images : [UIImage]
    var likedUsers: [User]
    var caption: String
    var comments: [Comment]
    var liked : Bool
    var bookmarked: Bool
    var postTime: Date
}
