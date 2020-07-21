//
//  CommentRouter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation

class CommentRouter: CommentRouterProtocol {
    
    class func createCommentModule(view: PostDetailViewController, post: Post) {
        let presenter = CommentPresenter()
        presenter.post = post
        view.presenter = presenter
        view.presenter?.wireframe = CommentRouter()
        view.presenter?.view = view
    }
    
    
    
}
