//
//  PostDetailViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/15/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import SnapKit
import FlexiblePageControl

class PostDetailTableViewController: UITableViewController {
    
    var presenter : FeedPresenterProtocol?
    var posts: [Post]?
    var onlyOnce = false
    var index: IndexPath?
    let cellId = "FeedCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "Posts"
    }
    
    override func viewDidLoad() {
        setupBasicViews(title: "Posts")
        //super.viewDidLoad()
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedTableViewCell
        cell.imageCollectionView.register(UINib(nibName: "PostImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedImageCell")
        cell.configure(post: (posts?[indexPath.row])!)
        configureGestures(index: indexPath.row, cell: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !onlyOnce {
            let indexPath = IndexPath(row: index!.row, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            onlyOnce = true
        }
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
        cell.likeView.addGestureRecognizer(likeTapGesture)
        cell.captionLbl.addGestureRecognizer(commentTapGesture)
        cell.commentLbl.addGestureRecognizer(commentTapGesture1)
        cell.commentBtn.addGestureRecognizer(commentTapGesture2)
    }
    

}

// MARK: - Navigations
extension PostDetailTableViewController {
    @objc func navigateToLikedListVC(sender: CustomTapGesture){
        let likedListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LikedListVC") as! LikedListViewController
        LikedListRouter.createLikedListModule(view: likedListVC, users: CurrentUser.shared.posts[sender.index].likedUsers)
        self.navigationController?.pushViewController(likedListVC, animated: true)
    }
    @objc func navigateToComment(sender: CustomTapGesture){
        let PostDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PostDetailVC") as! PostDetailViewController
        CommentRouter.createCommentModule(view: PostDetailVC, post: CurrentUser.shared.posts[sender.index])
        self.navigationController?.pushViewController(PostDetailVC, animated: true)
    }
}
