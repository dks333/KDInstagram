//
//  LikedListRouter.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

class LikedListRouter: LikedListRouterProtocol {
    func pushToProfileDetailModule(user: User, view: LikedListViewController) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileVC") as! ProfileViewController
        view.profileDelegate = profileVC
        view.profileDelegate?.getUser(user: user)
        view.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    class func createLikedListModule(view: LikedListViewController, users: [User]) {
        let presenter = LikedListPresenter()
        presenter.users = users
        view.presenter = presenter
        view.presenter?.wireframe = LikedListRouter()
        view.presenter?.view = view
    }
    
    
    
}
