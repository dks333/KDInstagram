//
//  LikedListProtocols.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

protocol LikedListViewProtocol: class {
    // Presenter ==> View
    func showLikedList(users: [User])
}

protocol LikedListPresenterProtocol: class {
    // View ==> Presenter
    var view: LikedListViewProtocol? {get set}
    var wireframe: LikedListRouterProtocol? {get set}
    
    func viewDidLoad()
    func showProfileSelection(user: User, view: LikedListViewController)
}

protocol LikedListInputInteractorProtocol: class {
    // Presenter ==> Interactor
}

protocol LikedListOutputInteractorProtocol: class {
    // Interactor ==> Presenter
    
}

protocol LikedListRouterProtocol: class {
    // Presenter ==> Wireframe
    static func createLikedListModule(view: LikedListViewController, users: [User])
    func pushToProfileDetailModule(user: User, view: LikedListViewController)
}
