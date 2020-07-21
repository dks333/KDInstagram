//
//  CommentProtocols.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation

protocol CommentViewProtocol: class {
    // Presenter ==> View
    func showComment(post: Post)
}

protocol CommentPresenterProtocol: class {
    // View ==> Presenter
    var view: CommentViewProtocol? {get set}
    var wireframe: CommentRouterProtocol? {get set}
    
    func viewDidLoad()
}

protocol CommentInputInteractorProtocol: class{
    // Presenter ==> Interactor
}

protocol CommentOutputInteractorProtocol: class {
    // Interactor ==> Presenter
}


protocol CommentRouterProtocol: class {
    // Presenter ==> Wireframe
    static func createCommentModule(view: PostDetailViewController, post: Post)
}
