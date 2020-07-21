//
//  ProfileViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

protocol ProfileDelegate: class {
    func getUser(user: User)
}

class ProfileViewController: SJSegmentedViewController, ProfileDelegate {

    var selectedSegment: SJSegmentTab?
    var user : User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfile()
    }
    
    override func viewDidLoad() {
        setupViewControllers()
        super.viewDidLoad()
        if let navController = self.navigationController, navController.viewControllers.count < 2 {
            self.user = CurrentUser.shared
        } else {
            if user?.username == "dks333" {
                self.user = CurrentUser.shared
            }
        }
        
    }
    
    func getUser(user: User) {
        self.user = user
    }
    
    // Pass Data to Child View Controller
    func setProfile(){
        navigationItem.title = self.user!.username
        if let postVC = segmentControllers[0] as? ProfilePostViewController {
            postVC.posts = self.user?.posts
        }
        if let header = headerViewController as? ProfileHeaderViewController {
            header.user = self.user
            header.update(completion: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.headerViewHeight = header.clview.frame.maxY + 8
                })
            })
        }
    }
    
    func setupViewControllers(){
        let headerVC = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileHeaderVC") as! ProfileHeaderViewController
        let profilePostVC = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfilePostVC") as! ProfilePostViewController
        setupTabIcon(vc: profilePostVC, image: UIImage(systemName: "square.grid.2x2")!)
        let profileTagVC = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfilePostVC") as! ProfilePostViewController
        setupTabIcon(vc: profileTagVC, image: UIImage(systemName: "person.crop.square")!)
        headerViewController = headerVC
        segmentControllers = [profilePostVC, profileTagVC]
        
        headerViewHeight = 350
        selectedSegmentViewHeight = 1.5
        headerViewOffsetHeight = 0
        selectedSegment?.backgroundColor = UIColor(named: "diffBgColor")!
        segmentTitleColor = .systemGray
        selectedSegmentViewColor = UIColor(named: "diffBgColor")!
        segmentShadow = SJShadow.init(offset: CGSize(width: 0, height: 1), color: .systemGray4, radius: .zero, opacity: 0.5)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        segmentBounces = true
        
        
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTabIcon(vc: UIViewController, image: UIImage){
        // Custom ImageView
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        view.image = image
        view.tintColor = UIColor(named: "diffBgColor")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        vc.navigationItem.titleView = view
    }
    
    

}
