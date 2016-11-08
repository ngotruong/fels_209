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
    @IBOutlet weak var learnedWordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "Cell"
    var user: [String: AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Profile"
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        fullnameLabel?.text = user["name"] as? String
        emailLabel?.text = user["email"] as? String
        learnedWordLabel?.text = "Learned \((user["learned_words"] as? Int)) words"
        if let linkImage = user["avatar"] as? String {
            if let url = NSURL(string: linkImage) {
                if let data = NSData(contentsOfURL: url) {
                    avataImageView.image = UIImage(data: data)
                } else {
                    avataImageView?.image = UIImage(named: "nonAvatar")
                }
            }
        }
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(UserProfile.editAction))
        navigationItem.rightBarButtonItem = button
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset.top = 0
    }
    
    func editAction() {
        if let profiles = self.storyboard?.instantiateViewControllerWithIdentifier("UpdateProfileViewController") as? UpdateProfileViewController {
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(profiles, animated: true)
        }
    }
    
    // MARK:  UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let activities = user["activities"] as? [[String : AnyObject]] else {
            return 0
        }
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.timeCreateLabel?.numberOfLines = 0
        cell.contentLabel?.numberOfLines = 0
        cell.avataImageView?.backgroundColor = UIColor.orangeColor()
        if let listActivities = user["activities"] as? [[String: AnyObject]] {
            let activities = listActivities[indexPath.row]
            cell.contentLabel?.text = activities["content"] as? String
            cell.timeCreateLabel?.text = activities["created_at"] as? String
        }
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.size.height / 3
    }
}
