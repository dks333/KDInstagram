//
//  LikedListViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class LikedListViewController: UIViewController, LikedListViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tbview: UITableView!
    
    weak var profileDelegate: ProfileDelegate?
    
    var presenter: LikedListPresenterProtocol?
    var likedUsers: [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Likes"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicViews(title: "Likes")
        tbview.tableFooterView = UIView()
        presenter?.viewDidLoad()
    }
    
    func showLikedList(users: [User]) {
        self.likedUsers = users
        tbview.reloadData()
    }
    

}


extension LikedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "LikedListCell", for: indexPath) as! LikedListTableViewCell
        cell.configure(user: likedUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showProfileSelection(user: likedUsers[indexPath.row], view: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

