//
//  ViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/2/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        signInButton?.layer.cornerRadius = 10
        signInButton?.layer.borderWidth = 3
        signInButton?.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton?.layer.cornerRadius = 10
        signUpButton?.layer.borderWidth = 3
        signUpButton?.layer.borderColor = UIColor.whiteColor().CGColor
        addIconToTextFields()
    }
    
    @IBAction func signinAction(sender: AnyObject) {
        weak var weakSelf = self
        loginService.signinBasic(emailTextField.text ?? "", password: passwordTextField.text ?? "", success: { (user) in
            if let profiles = weakSelf?.storyboard?.instantiateViewControllerWithIdentifier("UserProfile") as? UserProfileViewController {
                let users = User(fullname: user["name"] as? String ?? "", email: user["email"] as? String ?? "", learnedWords: user["learned_words"] as? Int ?? 0, avatar: user["avatar"] as? String ?? "", activities: user["activities"] as? [[String : AnyObject]] ?? [["": ""]])
                profiles.user = users
                dispatch_async(dispatch_get_main_queue(), {
                    weakSelf?.navigationController?.pushViewController(profiles, animated: true)
                })
            }
        }) { (message) in
            let alertValidateController = UIAlertController(title: "Message", message: "Invalid email/password combination", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            weakSelf?.presentViewController(alertValidateController, animated: true) {
            }
        }
    }
    
    @IBAction func signinFBAction(sender: AnyObject) {
        weak var weakSelf = self
        FBSDKLoginManager().logInWithReadPermissions(["email"], fromViewController: self) { (result, error) in
            self.loginService.signinUsingFB({ (users) in
                if let profiles = weakSelf?.storyboard?.instantiateViewControllerWithIdentifier("UserProfile") as? UserProfileViewController {
                    profiles.user = users
                    weakSelf?.navigationController?.pushViewController(profiles, animated: true)
                }}) { (message) in
                    let alertFailureController = UIAlertController(title: "Message", message: "Failed to get from facebook", preferredStyle: .Alert)
                    let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                    alertFailureController.addAction(OkButton)
                    weakSelf?.presentViewController(alertFailureController, animated: true) {
                    }
            }
        }
        
    }
    // MARK: - Add icons to the Textfields
    private func addIconToTextFields() {
        let imageViewEmail = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewEmail.contentMode = UIViewContentMode.Center
        let imageEmail  = UIImage(named: "email_icon")
        imageViewEmail.image = imageEmail
        emailTextField?.leftView = imageViewEmail
        emailTextField?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewPassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewPassword.contentMode = UIViewContentMode.Center
        let imagePassword  = UIImage(named: "password_icon")
        imageViewPassword.image = imagePassword
        passwordTextField?.leftView = imageViewPassword
        passwordTextField?.leftViewMode = UITextFieldViewMode.Always
    }
}
