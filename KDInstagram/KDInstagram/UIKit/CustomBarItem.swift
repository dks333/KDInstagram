//
//  CustomUITabBarItem.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class CustomTabBarItem: UITabBarItem {
    
    override func awakeFromNib() {
        self.title = ""
        self.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0);
    }
}
