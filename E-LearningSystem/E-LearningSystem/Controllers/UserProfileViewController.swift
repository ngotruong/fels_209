//
//  UserProfile.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/4/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var learnedWordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    let cellIdentifier = "Cell"
    private var lisActivities: [[String: AnyObject]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        self.title = "Profile"
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        fullnameLabel?.text = user.fullname
        emailLabel?.text = user.email
        learnedWordLabel?.text = "Learned \(user.learnedWords) words"
        let linkImage = user.avatar
        if let url = NSURL(string: linkImage) {
            if let data = NSData(contentsOfURL: url) {
                avataImageView?.image = UIImage(data: data)
            } else {
                avataImageView?.image = UIImage(named: "nonAvatar")
            }
        }
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(UserProfileViewController.editAction))
        navigationItem.rightBarButtonItem = button
        tableView?.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        lisActivities = user.activities
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView?.contentInset.top = 0
    }
    
    func editAction() {
        print("Edit")
    }
    
    // MARK:  UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lisActivities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeTableViewCell {
            cell.timeCreateLabel?.numberOfLines = 0
            cell.contentLabel?.numberOfLines = 0
            cell.avataImageView?.backgroundColor = UIColor.orangeColor()
            let activities = lisActivities[indexPath.row]
            cell.contentLabel?.text = activities["content"] as? String
            cell.timeCreateLabel?.text = activities["created_at"] as? String
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.size.height / 3
    }
}
