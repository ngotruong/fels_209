//
//  UserProfile.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/4/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PassingDataDelegate {
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
    let logOutService = LogoutService()

    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordButton?.round(10, borderWith: 1, borderColor: UIColor.grayColor().CGColor)
        lessionButton?.round(10, borderWith: 1, borderColor: UIColor.grayColor().CGColor)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.title = "Profile"
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(UserProfileViewController.editAction))
        navigationItem.rightBarButtonItem = button
        tableView?.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.frame = CGRect(x: avataImageView.bounds.size.width/2 - 20, y: avataImageView.bounds.size.height/2 - 20, width: 50, height: 50)
        avataImageView?.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        fullnameLabel?.text = user.fullname
        emailLabel?.text = user.email
        learnedWordLabel?.text = "Learned \(user.learnedWords) words"
        let linkImage = user.avatar
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let url = NSURL(string: linkImage) {
                self.activityIndicator.startAnimating()
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.avataImageView?.image = UIImage(data: data)
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    self.avataImageView?.image = UIImage(named: "nonAvatar")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView?.contentInset.top = 0
    }
    
    @objc private func logOut() {
        LoadingIndicatorView.show(self.view, loadingText: "Loading")
        weak var weakSelf = self
        logOutService.getLogOut(user.authToken, success: { (success) in
            dispatch_async(dispatch_get_main_queue(), {
                LoadingIndicatorView.hide()
                weakSelf?.navigationController?.popViewControllerAnimated(true)
            })
            }, failure: { (message) in
                LoadingIndicatorView.hide()
                let alertValidateController = UIAlertController(title: "Message", message: message["message"] ?? "", preferredStyle: .Alert)
                let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                alertValidateController.addAction(OkButton)
                weakSelf?.presentViewController(alertValidateController, animated: true) {
                }
        })
    }
    
    @objc private func editAction() {
        if let profiles = self.storyboard?.instantiateViewControllerWithIdentifier("UpdateProfileViewController") as? UpdateProfileViewController {
            profiles.user = user
            profiles.delegate = self
            let navController = UINavigationController(rootViewController: profiles)
            self.presentViewController(navController, animated:true, completion: nil)
        }
    }
    
    func didSaveUser(user: User) {
        self.user = user
        fullnameLabel?.text = user.fullname
        emailLabel?.text = user.email
        learnedWordLabel?.text = "Learned \(user.learnedWords) words"
        let linkImage = user.avatar
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let url = NSURL(string: linkImage) {
                self.activityIndicator.startAnimating()
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.avataImageView?.image = UIImage(data: data)
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    self.avataImageView?.image = UIImage(named: "nonAvatar")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func showLession(sender: AnyObject) {
        weak var weakSelf = self
        LoadingIndicatorView.show(self.view, loadingText: "Loading")
        categories.getCategories(user.authToken, success: { (cate) in
            if let categori = weakSelf?.storyboard?.instantiateViewControllerWithIdentifier("Categories") as? CategoriesViewController {
                categori.listCategories.appendContentsOf(cate)
                categori.user = self.user
                LoadingIndicatorView.hide()
                weakSelf?.navigationController?.pushViewController(categori, animated: true)
            }
        }) { (message) in
            LoadingIndicatorView.hide()
            let alertValidateController = UIAlertController(title: "Message", message: message["message"] ?? "", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            weakSelf?.presentViewController(alertValidateController, animated: true) {
            }
        }
    }
    
    @IBAction func showWordList(sender: AnyObject) {
        weak var weakSelf = self
        LoadingIndicatorView.show(self.view, loadingText: "Loading")
        categories.getCategories(user.authToken, success: { (cate) in
            if let wordVC = weakSelf?.storyboard?.instantiateViewControllerWithIdentifier("WordList") as? WordViewController {
                wordVC.listCategories.appendContentsOf(cate)
                wordVC.token = self.user.authToken
                LoadingIndicatorView.hide()
                weakSelf?.navigationController?.pushViewController(wordVC, animated: true)
            }
        }) { (message) in
            let alertValidateController = UIAlertController(title: "Message", message: message["message"] ?? "", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            LoadingIndicatorView.hide()
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
