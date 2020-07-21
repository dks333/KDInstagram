//
//  ProfileHeaderViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/14/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class ProfileHeaderViewController: UIViewController {

    @IBOutlet weak var clview: UICollectionView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var postNumBtn: UIButton!
    @IBOutlet weak var followerBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    @IBOutlet weak var profileDescriptionLbl: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var suggestionBtn: UIButton!
    
    var editBtn: UIButton!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func update(completion: () -> ()) {
        guard let user = user else { return }
        clview.reloadData()
        profileImgView.image = user.profilePic
        
        let styleForLineSpacing = NSMutableParagraphStyle()
        styleForLineSpacing.lineSpacing = 3
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\n" + user.description, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.addAttribute(.paragraphStyle, value: styleForLineSpacing, range: NSMakeRange(0, attributedText.length))
        profileDescriptionLbl.attributedText = attributedText
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineSpacing = 1
    
        let postAttibutedText = NSMutableAttributedString(string: "\(String(describing: user.posts.count))", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        postAttibutedText.append(NSAttributedString(string: "\nPost", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        postAttibutedText.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, postAttibutedText.length))
        postNumBtn.setAttributedTitle(postAttibutedText, for: .normal)
        
        let followerAttibutedText = NSMutableAttributedString(string: "\(String(describing: user.followers.count))", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        followerAttibutedText.append(NSAttributedString(string: "\nFollowers", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        followerAttibutedText.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, followerAttibutedText.length))
        followerBtn.setAttributedTitle(followerAttibutedText, for: .normal)
        
        
        let followingAttibutedText = NSMutableAttributedString(string: "\(String(describing: user.following.count))", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        followingAttibutedText.append(NSAttributedString(string: "\nFollowing", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        followingAttibutedText.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, followingAttibutedText.length))
        followingBtn.setAttributedTitle(followingAttibutedText, for: .normal)
        
        // If the user is the current User
        if user.username == CurrentUser.shared.username {
            view.setNeedsLayout()
            editBtn = UIButton()
            editBtn.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(editBtn)
            editBtn.snp.makeConstraints({ make in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(26)
                make.top.equalTo(profileDescriptionLbl.snp.bottom).offset(15)
            })
            let editAttributedText = NSMutableAttributedString(string: "Edit Profile", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            editBtn.setAttributedTitle(editAttributedText, for: .normal)
            editBtn.setTitleColor(UIColor(named: "diffBgColor")!, for: .normal)
            editBtn.layer.cornerRadius = 5
            editBtn.layer.borderColor = UIColor.systemGray2.cgColor
            editBtn.layer.borderWidth = 0.5
            
            
            followBtn.alpha = 0
            messageBtn.alpha = 0
            suggestionBtn.alpha = 0
        }
        
        view.layoutIfNeeded()
        completion()
    }
    
    private func setupView(){
        profileDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        postNumBtn.translatesAutoresizingMaskIntoConstraints = false
        followerBtn.translatesAutoresizingMaskIntoConstraints = false
        followingBtn.translatesAutoresizingMaskIntoConstraints = false
        
        profileImgView.layer.cornerRadius = 40
        profileImgView.layer.borderWidth = 0.5
        profileImgView.layer.borderColor = UIColor.systemGray3.cgColor
        
        followBtn.layer.cornerRadius = 5
        followBtn.layer.borderColor = UIColor.systemGray2.cgColor
        followBtn.layer.borderWidth = 0.5
        
        messageBtn.layer.cornerRadius = 5
        messageBtn.layer.borderColor = UIColor.systemGray2.cgColor
        messageBtn.layer.borderWidth = 0.5
        
        suggestionBtn.layer.cornerRadius = 5
        suggestionBtn.layer.borderColor = UIColor.systemGray2.cgColor
        suggestionBtn.layer.borderWidth = 0.5
        
    }
    
    @IBAction func messageUser(_ sender: Any) {
        self.presentAlert(message: "Message function has not been implemented")
    }
    



}

extension ProfileHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
