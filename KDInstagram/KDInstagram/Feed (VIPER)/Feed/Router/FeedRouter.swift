//
//  FeedRouter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

class FeedRouter: FeedRouterProtocol {
    
    func pushToProfileDetailModule(user: User, view: FeedViewController) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileVC") as! ProfileViewController
        view.profileDelegate = profileVC
        view.profileDelegate?.getUser(user: user)
        view.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func pushToLikedListModule(user: [User], view: UIViewController) {
        let likedListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LikedListVC") as! LikedListViewController
        LikedListRouter.createLikedListModule(view: likedListVC, users: user)
        view.navigationController?.pushViewController(likedListVC, animated: true)
    }
    
    func pushToPostDetailModule(post: Post, view: UIViewController) {
        let PostDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PostDetailVC") as! PostDetailViewController
        CommentRouter.createCommentModule(view: PostDetailVC, post: post)
        view.navigationController?.pushViewController(PostDetailVC, animated: true)
    }
    
    class func createFeedModule(feed: FeedViewController) {
        let presenter : FeedPresenterProtocol & FeedOutputInteractorProtocol = FeedPresenter()
        
        feed.presenter = presenter
        feed.presenter?.wireframe = FeedRouter()
        feed.presenter?.interactor = FeedInteractor()
        feed.presenter?.view = feed
        feed.presenter?.interactor?.presenter = presenter
        
    }
    
    
}
