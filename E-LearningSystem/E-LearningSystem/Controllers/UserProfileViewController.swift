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
    @IBOutlet weak var wordButton: UIButton!
    @IBOutlet weak var lessionButton: UIButton!
    
    var user: User!
    let cellIdentifier = "Cell"
    var lisActivities = [[String: AnyObject]]()
    var categories = CategoriesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordButton?.round(10, borderWith: 1, borderColor: UIColor.grayColor().CGColor)
        lessionButton?.round(10, borderWith: 1, borderColor: UIColor.grayColor().CGColor)
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView?.contentInset.top = 0
    }
    
    @objc private func editAction() {
        if let profiles = self.storyboard?.instantiateViewControllerWithIdentifier("UpdateProfileViewController") as? UpdateProfileViewController {
            let navController = UINavigationController(rootViewController: profiles)
            self.presentViewController(navController, animated:true, completion: nil)
        }
    }
    
    @IBAction func showLession(sender: AnyObject) {
        weak var weakSelf = self
        categories.getCategories(user.authToken, success: { (cate) in
            if let categori = weakSelf?.storyboard?.instantiateViewControllerWithIdentifier("Categories") as? CategoriesViewController {
                categori.listCategories.appendContentsOf(cate)
                weakSelf?.navigationController?.pushViewController(categori, animated: true)
            }
        }) { (message) in
            let alertValidateController = UIAlertController(title: "Message", message: message["message"] ?? "", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            weakSelf?.presentViewController(alertValidateController, animated: true) {
            }
        }
    }
    
    // MARK:  UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lisActivities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeTableViewCell {
            cell.configCellWithContent(lisActivities[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.size.height / 3
    }
}
