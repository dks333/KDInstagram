//
//  FeedTableViewCell.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import SnapKit
import FlexiblePageControl
import Lottie

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileSectionView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.delegate = self
            imageCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var likeBtn: UIButton! {
        didSet {
            likeBtn.addTarget(self, action: #selector(self.likePost), for: .touchUpInside)
        }
    }
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var pageControl: FlexiblePageControl! {
        didSet {
            pageControl.numberOfPages = 6
            pageControl.pageIndicatorTintColor = .systemGray
            pageControl.currentPageIndicatorTintColor = .systemBlue
        }
    }
    @IBOutlet weak var bookMarkBtn: UIButton!
    
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    var animationView = AnimationView(name: "heart")
    var post : Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationView = AnimationView(name: "heart")
        animationView.animationSpeed = 1.7
        animationView.loopMode = .playOnce
        self.contentView.addSubview(animationView)
        animationView.snp.makeConstraints({ make in
            make.height.width.equalTo(110)
            make.center.equalTo(imageCollectionView)
        })
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.animateHeart))
        doubleTap.numberOfTapsRequired = 2
        imageCollectionView.addGestureRecognizer(doubleTap)
        
        
    }
    
    func configure(post: Post){
        self.post = post
        if post.images.count == 1 {
            pageControl.alpha = 0
        } else {
            // size
            pageControl.alpha = 1
            let config = FlexiblePageControl.Config(
                displayCount: 6,
                dotSize: 6,
                dotSpace: 4,
                smallDotSizeRatio: 0.5,
                mediumDotSizeRatio: 0.7
            )
            pageControl.setConfig(config)
            pageControl.numberOfPages = post.images.count
            
        }
        setupProfile()
        setupLikeLbl()
        setupCaption()
        setupCommentAndTimeLbl()
        imageCollectionView.reloadData()
    }
    
    func setupProfile(){
        profileImgView.image = post!.user.profilePic
        profileImgView.drawCornerRadius(radius: CGSize(width: profileImgView.frame.width, height: profileImgView.frame.width))
        profileImgView.layer.borderWidth = 0.5
        profileImgView.layer.borderColor = UIColor.systemGray3.cgColor
        usernameLbl.text = post!.user.username
    }
    
    func setupCaption(){
        let attributedText = NSMutableAttributedString(string: (post!.user.username), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(post!.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        captionLbl.attributedText = attributedText
    }
    
    func setupLikeLbl(){
        let attributedText = NSMutableAttributedString(string: "\(String(describing: post!.likedUsers.count)) likes", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        likeLbl.attributedText = attributedText
    }
    
    func setupCommentAndTimeLbl(){
        commentLbl.text = "View all \(String(describing: post!.comments.count)) comments"
        timeLbl.text = post!.postTime.timeAgoDisplay()
    }
    
    @objc func likePost(){
        if !post!.liked {
            likeBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeBtn.tintColor = .systemRed
        } else {
            likeBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            likeBtn.tintColor = UIColor(named: "diffBgColor")
        }
        post!.liked = !post!.liked
    }
    
    @objc func animateHeart(){
        UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
        animationView.play()
        likeBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeBtn.tintColor = .systemRed
        post!.liked = true
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        print("Share Button Tapped")
    }
        
    @IBAction func bookmarkBtnTapped(_ sender: Any) {
        print("Bookmark Button Tapped")
    }
    
    @IBAction func moreBtnTapped(_ sender: Any) {
        print("More Button Tapped")
    }
}



extension FeedTableViewCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post?.images.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCell", for: indexPath) as! FeedImageCollectionViewCell
        cell.configure(image: (post?.images[indexPath.item])!)
        return cell
     }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 331)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setCurrentPage(at: Int(scrollView.contentOffset.x  / self.frame.width))
    }
    
    
    
}
