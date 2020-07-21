//
//  CommentPresenter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation

class CommentPresenter: CommentPresenterProtocol {
    
    var view: CommentViewProtocol?
    var wireframe: CommentRouterProtocol?
    var post: Post!
    
    func viewDidLoad() {
        view?.showComment(post: post)
    }
    
    
}
