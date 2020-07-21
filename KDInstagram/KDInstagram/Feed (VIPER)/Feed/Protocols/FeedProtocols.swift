//
//  FeedProtocols.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter Updates the View
protocol FeedViewProtocol: class {
    // Presenter ==> View
    func showFeedList(post: [Post])
}

// MARK: - View send user actions to Presenter
protocol FeedPresenterProtocol: class {
    // View ==> Presenter
    var interactor: FeedInputInteractorProtocol? {get set}
    var view : FeedViewProtocol? {get set}
    var wireframe: FeedRouterProtocol? {get set}
    
    func viewDidLoad()
    func showPostSelection(post: Post, view: UIViewController)
    func showProfileSelection(user: User, view: FeedViewController)
    func showLikedList(users: [User], view: UIViewController)    
//    func setLike(liked: Bool)
//    func setBookmark(bookmarked: Bool)
}

// MARK: - Presenter send request to Interactor
protocol FeedInputInteractorProtocol: class {
    // Presenter ==> Interactor
    var presenter: FeedOutputInteractorProtocol? {get set}
    func getPosts()
    
}

// MARK: - Interactor updates the Presenter
protocol FeedOutputInteractorProtocol: class {
    // Interactor ==> Presenter
    func postsDidFetch(post: [Post])
}

// MARK: - Router controls Flow
protocol FeedRouterProtocol: class {
    // Presenter ==> Router
    func pushToProfileDetailModule(user: User, view: FeedViewController)
    func pushToLikedListModule(user: [User], view: UIViewController)
    func pushToPostDetailModule(post: Post, view: UIViewController)
    static func createFeedModule(feed: FeedViewController)
}

