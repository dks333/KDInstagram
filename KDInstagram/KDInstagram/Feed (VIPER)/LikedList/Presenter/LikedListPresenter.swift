//
//  LikedListPresenter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation

class LikedListPresenter: LikedListPresenterProtocol {
    
    var view: LikedListViewProtocol?
    var wireframe: LikedListRouterProtocol?
    var users: [User]!
    
    func viewDidLoad() {
        view?.showLikedList(users: users)
    }
    
    func showProfileSelection(user: User, view: LikedListViewController) {
        wireframe?.pushToProfileDetailModule(user: user, view: view)
    }
    
    
}
