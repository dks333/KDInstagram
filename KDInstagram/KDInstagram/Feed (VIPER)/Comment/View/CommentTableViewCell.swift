//
//  CommentTableViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var commentTimeLbl: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var comment: Comment!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.drawCornerRadius(radius: CGSize(width: profileImgView.bounds.width / 2, height: profileImgView.bounds.width / 2))
        profileImgView.layer.borderWidth = 0.5
        profileImgView.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func configure(comment: Comment){
        self.comment = comment
        profileImgView.image = comment.user.profilePic
        
        let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(comment.content)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        commentLbl.attributedText = attributedText
        
        commentTimeLbl.text = comment.date.timeAgoDisplayShort()
        
        likeLbl.text = "\(comment.likes) likes"
    }

}
