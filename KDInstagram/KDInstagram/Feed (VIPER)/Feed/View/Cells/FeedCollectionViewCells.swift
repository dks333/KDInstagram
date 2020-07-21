//
//  FeedImageCollectionViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class FeedImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgView: EEZoomableImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: UIImage){
        self.imgView.image = image
    }
    
    
}



