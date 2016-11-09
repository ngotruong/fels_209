//
//  RegisterViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/2/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    var signupService = SignupService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton?.layer.cornerRadius = 10
        createAccountButton?.layer.borderWidth = 2
        createAccountButton?.layer.borderColor = UIColor.whiteColor().CGColor
        signInButton?.layer.cornerRadius = 10
        signInButton?.layer.borderWidth = 2
        signInButton?.layer.borderColor = UIColor.whiteColor().CGColor
        addIconToTextFields()
    }
    
    @IBAction func signIn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        let imageViewConfirmPass = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewConfirmPass.contentMode = UIViewContentMode.Center
        let imageConfirmPass  = UIImage(named: "password_icon")
        imageViewConfirmPass.image = imageConfirmPass
        confirmPasswordTextField?.leftView = imageViewConfirmPass
        confirmPasswordTextField?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewFullname = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewFullname.contentMode = UIViewContentMode.Center
        let imageFullname  = UIImage(named: "fullname_icon")
        imageViewFullname.image = imageFullname
        fullnameTextField?.leftView = imageViewFullname
        fullnameTextField?.leftViewMode = UITextFieldViewMode.Always
    }
    
    @IBAction func createAccountAction(sender: AnyObject) {
        weak var wearkSelf = self
        let signupUser = SignupUser(name: fullnameTextField?.text ?? "", email: emailTextField?.text ?? "", password: passwordTextField?.text ?? "", passwordConfirmation: confirmPasswordTextField?.text ?? "")
        signupService.handleLogicSignup(signupUser, success: { (user) in
            wearkSelf?.dismissViewControllerAnimated(true, completion: nil)
            }, validate: { (message) in
                let alertValidateController = UIAlertController(title: "Message", message: message, preferredStyle: .Alert)
                let OkButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertValidateController.addAction(OkButton)
                wearkSelf?.presentViewController(alertValidateController, animated: true) {
                }
        }) { (message) in
            print("failed")
            let alertFailedController = UIAlertController(title: "Message", message: message, preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertFailedController.addAction(OkButton)
            wearkSelf?.presentViewController(alertFailedController, animated: true) {
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
