//
//  FeedInteractor.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation


class FeedInteractor: FeedInputInteractorProtocol {
    
    weak var presenter: FeedOutputInteractorProtocol?
    func getPosts() {
        presenter?.postsDidFetch(post: getAllPosts())
    }
    
    private func getAllPosts() -> [Post]{
        return dataGenerator.generateData(){_ in}
    }
    
}
