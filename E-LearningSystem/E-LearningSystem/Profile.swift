//
//  Profile.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/5/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class Profile: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func signOutAction(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        let loginViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController)!
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = loginViewController
    }
}
