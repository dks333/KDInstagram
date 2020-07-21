//
//  FirstViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, FeedViewProtocol {

    @IBOutlet weak var tbview: UITableView!
    @IBOutlet weak var clview: UICollectionView!
    
    var presenter : FeedPresenterProtocol?
    var posts : [Post] = []
    
    
    weak var profileDelegate: ProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        FeedRouter.createFeedModule(feed: self)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Instagram"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func setupView(){
        tbview.tableFooterView = UIView()
    }
    
    func showFeedList(post: [Post]) {
        posts = post
        DispatchQueue.main.async {
            self.tbview.reloadData()
        }
    }
    @IBAction func showMessageVC(_ sender: Any) {
        self.presentAlert(message: "Chat has not been implemented")
    }
    @IBAction func takePhoto(_ sender: Any) {
        self.presentAlert(message: "Story function has not been implemented")
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let post = self.posts[indexPath.row]
        cell.configure(post: post)
        self.configureGestures(index: indexPath.row, cell: cell)
        return cell
    }
    
    
    func configureGestures(index: Int, cell: FeedTableViewCell){
        let commentTapGesture = CustomTapGesture(target: self, action: #selector(self.navigateToComment(sender:)))
        commentTapGesture.index = index
        let commentTapGesture1 = CustomTapGesture(target: self, action: #selector(self.navigateToComment(sender:)))
        commentTapGesture1.index = index
        let commentTapGesture2 = CustomTapGesture(target: self, action: #selector(self.navigateToComment(sender:)))
        commentTapGesture2.index = index
        let likeTapGesture = CustomTapGesture(target: self, action: #selector(self.navigateToLikedListVC(sender:)))
        likeTapGesture.index = index
        let profileTapGesture = CustomTapGesture(target: self, action: #selector(self.navigateToProfile(sender:)))
        profileTapGesture.index = index
        cell.likeView.addGestureRecognizer(likeTapGesture)
        cell.captionLbl.addGestureRecognizer(commentTapGesture)
        cell.commentLbl.addGestureRecognizer(commentTapGesture1)
        cell.commentBtn.addGestureRecognizer(commentTapGesture2)
        cell.profileSectionView.addGestureRecognizer(profileTapGesture)
    }
    
    
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentAlert(message: "Story function has not been implemented")
    }
    
    
}

// MARK: - Navigations
extension FeedViewController {
    @objc func navigateToLikedListVC(sender: CustomTapGesture){
        presenter?.showLikedList(users: posts[sender.index].likedUsers, view: self)
    }
    @objc func navigateToProfile(sender: CustomTapGesture){
        presenter?.showProfileSelection(user: posts[sender.index].user, view: self)
    }
    @objc func navigateToComment(sender: CustomTapGesture){
        presenter?.showPostSelection(post: posts[sender.index], view: self)
    }
}

class CustomTapGesture: UITapGestureRecognizer {
    var index = Int()
}
