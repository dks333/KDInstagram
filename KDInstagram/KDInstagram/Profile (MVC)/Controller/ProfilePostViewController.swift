//
//  ProfilePostViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/14/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import SnapKit

class ProfilePostViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    var posts: [Post]? {
        willSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate var imgWidth : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgWidth = collectionView.frame.width / 3 - 1
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! ProfilePostCell
        if let posts = posts{
            cell.imgView.image = posts[indexPath.row].images.first //.resize(size: CGSize(width: imgWidth, height: imgWidth))
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PostDetailTableViewController()
        vc.posts = posts
        vc.index = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imgWidth, height: imgWidth)
    }
    

}

class ProfilePostCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
    }
}

