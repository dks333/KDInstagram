//
//  SuggestedPostCollectionViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/16/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SuggestedPostCollectionViewCell: UICollectionViewCell {
    
    var suggestedPost : Post!
    var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        contentView.layoutIfNeeded()
        
    }
    
    func configure(post: Post){
        self.suggestedPost = post
        //let resizedImage = post.images.first?.resize(size: self.frame.size)
        imgView.image =  post.images.first
    }
}
