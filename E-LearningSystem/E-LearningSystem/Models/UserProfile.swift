//
//  UserProfile.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/4/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UserProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var fullname: String!
    var email: String!
    var learnedWord: Int!
    var listActivities: [String: AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Profile"
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        avataImageView.backgroundColor = UIColor.orangeColor()
        fullnameLabel?.text = fullname
        emailLabel?.text = email
        idLabel?.text = "Learned \(learnedWord) words"
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        print(listActivities.keys)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.contentInset.top = 0
    }
    
    // MARK:  UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listActivities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeTableViewCell)!
        cell.time?.numberOfLines = 0
        cell.learnedWordLabel?.numberOfLines = 0
        cell.avataImageView?.backgroundColor = UIColor.orangeColor()
//        cell.learnedWordLabel?.text = listActivities["content"][indexPath.row] as! String
        cell.time?.text = "dasdsadsacshfkdsjfkffsddsfdsfsdfdsfsdfsdfdsfdsfdsfdsfs"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.size.height / 3
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
