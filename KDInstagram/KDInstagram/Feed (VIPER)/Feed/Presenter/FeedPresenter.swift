//
//  FeedPresenter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

class FeedPresenter: FeedPresenterProtocol {
    
    
    var interactor: FeedInputInteractorProtocol?
    var view: FeedViewProtocol?
    var wireframe: FeedRouterProtocol?
    
    func viewDidLoad() {
        self.loadFeed()
    }
    
    private func loadFeed(){
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getPosts()
        }
    }
    
    // MARK: InputInteractorProtocol Functions
    func showPostSelection(post: Post, view: UIViewController) {
        wireframe?.pushToPostDetailModule(post: post, view: view)
    }
    
    func showProfileSelection(user: User, view: FeedViewController) {
        wireframe?.pushToProfileDetailModule(user: user, view: view)
    }
    
    func showLikedList(users: [User], view: UIViewController) {
        wireframe?.pushToLikedListModule(user: users, view: view)
    }
    
    
}

extension FeedPresenter: FeedOutputInteractorProtocol {
    func postsDidFetch(post: [Post]) {
        view?.showFeedList(post: post)
    }
    
}
