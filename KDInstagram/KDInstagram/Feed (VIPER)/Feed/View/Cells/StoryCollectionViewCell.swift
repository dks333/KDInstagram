//
//  StoryCollectionViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/17/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import SnapKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var nameLbl: UILabel!
    
    var user: User!
    
    var imageViewWidth : CGFloat = 58
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = imageViewWidth / 2
        imgView.backgroundColor = .systemTeal
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints({make in
            make.width.height.equalTo(imageViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        })
        
        nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        nameLbl.text = "username"
        self.contentView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints({make in
            make.width.equalTo(55)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(5)
        })
    }
    
    func configure(user: User){
        self.imgView.image = user.profilePic
        self.nameLbl.text = user.username
    }
}
