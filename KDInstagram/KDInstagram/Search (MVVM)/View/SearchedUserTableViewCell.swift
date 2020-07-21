//
//  SearchedUserTableViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/17/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import SnapKit

class SearchedUserTableViewCell: UITableViewCell {
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.isOpaque = true
        self.contentView.addSubview(imgView)
        imgView.drawCornerRadius(radius: CGSize(width: profileImageWidth / 2, height: profileImageWidth / 2))
        return imgView
    }()
    
    lazy var usernameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    private var profileImageWidth : CGFloat = 42
    
    private var user: User!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func configure(user: User){
        self.user = user
        imgView.image = user.profilePic.resize(size: CGSize(width: profileImageWidth, height: profileImageWidth))
        usernameLbl.text = user.username
        nameLbl.text = user.name
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 7.5, width: profileImageWidth, height: profileImageWidth))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageWidth / 2
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        imageView.image = user.profilePic.resize(size:  CGSize(width: profileImageWidth, height: profileImageWidth))
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }
    
    fileprivate func setupView(){
        imgView.snp.makeConstraints({ make in
            make.height.width.equalTo(profileImageWidth)
            make.left.equalToSuperview().offset(13)
            make.centerY.equalToSuperview()
        })
        
        usernameLbl.snp.makeConstraints({ make in
            make.left.equalTo(imgView.snp.right).offset(8)
            make.top.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-20)
        })
        
        nameLbl.snp.makeConstraints({ make in
            make.left.equalTo(imgView.snp.right).offset(8)
            make.top.equalTo(usernameLbl.snp.bottom).offset(2)
            make.right.equalToSuperview().offset(-20)
        })
    }

}
