//
//  LikedListTableViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class LikedListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.drawCornerRadius(radius: CGSize(width: profileImg.frame.width/2, height: profileImg.frame.width/2))
        followBtn.drawCornerRadius(radius: CGSize(width: 5, height: 5))
        profileImg.layer.borderWidth = 0.5
        profileImg.layer.borderColor = UIColor.systemGray3.cgColor
    }

    func configure(user: User){
        profileImg.image = user.profilePic
        usernameLbl.text = user.username
        nameLbl.text = user.name
        
    }

}
