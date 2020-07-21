//
//  FeedTableView.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit

class FeedTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 580
    }
    
    

}
