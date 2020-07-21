//
//  SearchItem.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/16/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import RxDataSources

//enum SearchItem: IdentifiableType {
//
//    case suggestedTopic(SuggestedTopic)
//    case suggestedPost(Post)
//    
//    var identity: Int {
//        switch self {
//        case let .suggestedTopic(topic):
//            return topic.name.hashValue
//        case let .suggestedPost(post):
//            return post.user.username.hashValue
//        }
//    }
//}
//
//extension SearchItem: Equatable {
//    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
//        switch (lhs, rhs) {
//        case let (.suggestedTopic(topic1), .suggestedTopic(topic2)):
//            return topic1.name.hashValue == topic2.name.hashValue
//        case let (.suggestedPost(post1), .suggestedPost(post2)):
//            return post1.user.username.hashValue == post2.user.username.hashValue
//        default:
//            return false
//        }
//    }
//    
//}
