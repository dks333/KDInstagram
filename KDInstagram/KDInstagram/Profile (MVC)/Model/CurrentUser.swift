//
//  CurrentUser.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit


let dataGenerator = DataGenerator()

class CurrentUser {
    
    static let shared : User = {
        let user = dataGenerator.getCurrentUser()
        return user
    }()
    
    private init() {}
}
