//
//  PostDetailViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GrowingTextView

class PostDetailViewController: UIViewController, CommentViewProtocol, GrowingTextViewDelegate {
    
    
    @IBOutlet weak var tbview: UITableView!
    @IBOutlet weak var textview: GrowingTextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    
    var headerView = UIView()
    var profileView = UIImageView()
    var captionLabel = UILabel()
    var postTimeLabel = UILabel()
    var oneHeight = 0
    var keyboardHeight = 0 {
        willSet {
            if newValue != 0 {
                textview.transform = CGAffineTransform(translationX: 0, y: -CGFloat(newValue) + textview.bounds.height - 10)
                imgView.transform = CGAffineTransform(translationX: 0, y: -CGFloat(newValue) + imgView.bounds.height - 10)
                postBtn.transform = CGAffineTransform(translationX: 0, y: -CGFloat(newValue) + postBtn.bounds.height - 10)
            } else {
                textview.transform = .identity
                imgView.transform = .identity
                postBtn.transform = .identity
            }
        }
    }
    
    var presenter: CommentPresenterProtocol?
    var post: Post!
    var comments: [Comment] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupBasicViews(title: "Comments")
        setupView()
        presenter?.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textview.placeholder = "Add a comment"
        textview.layer.cornerRadius = 15
        textview.layer.borderColor = UIColor.systemGray3.cgColor
        textview.layer.borderWidth = 0.7
        textview.textContainer.lineFragmentPadding = 10
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            if let height = UserDefaults.standard.value(forKey: "KeyboardHeight"){
                oneHeight = height as! Int
            } else {
                oneHeight = Int(keyboardSize.height + 25 - view.safeAreaInsets.bottom)
                UserDefaults.standard.set(oneHeight, forKey: "KeyboardHeight")
            }
            keyboardHeight = isKeyboardShowing ? oneHeight : 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTabBarVisible(visible: false, animated: true)
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.setTabBarVisible(visible: true, animated: true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
    }
    
    private func setupView(){
        tbview.tableFooterView = UIView()
        createPostView()
        //tbview.tableHeaderView = headerView
        tbview.sectionHeaderHeight = UITableView.automaticDimension
        
        self.imgView.image = CurrentUser.shared.profilePic
        self.imgView.drawCornerRadius(radius: CGSize(width: 14.5, height: 14.5))
    }
    
    func showComment(post: Post) {
        self.post = post
        self.comments = post.comments
        updateHeader()
        self.tbview.reloadData()
    }
    
    private func updateHeader(){
        profileView.image = post.user.profilePic
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        captionLabel.attributedText = attributedText
        
        postTimeLabel.attributedText = NSMutableAttributedString(string: post.postTime.timeAgoDisplay(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular)])
        
    }
    
    func createPostView(){
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.contentMode = .scaleAspectFill
        profileView.layer.cornerRadius = 14.5
        profileView.clipsToBounds = true
        headerView.addSubview(profileView)
        profileView.snp.makeConstraints({make in
            make.top.left.equalTo(13)
            make.width.equalTo(29)
            make.height.equalTo(29)
        })

        
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.numberOfLines = 0
        headerView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints({make in
            make.left.equalTo(profileView.snp.right).offset(8)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        })

        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.textColor = .systemGray
        headerView.addSubview(postTimeLabel)
        postTimeLabel.snp.makeConstraints({make in
            make.left.equalTo(profileView.snp.right).offset(8)
            make.bottom.equalTo(-20)
            make.right.equalTo(-10)
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
        })
    }
    
    @IBAction func postAction(_ sender: Any) {
        if !textview.text.isEmpty {
            let commentContent = textview.text.trimmingCharacters(in: .whitespacesAndNewlines)
            comments.append(Comment(user: CurrentUser.shared, content: commentContent, date: Date(), likes: 0))
            tbview.reloadData()
            textview.endEditing(true)
            keyboardHeight = 0
            textview.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end")
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.configure(comment: comments[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.addLine(position: "bottom", color: .systemGray4, width: 0.5)
        return headerView
    }
}
