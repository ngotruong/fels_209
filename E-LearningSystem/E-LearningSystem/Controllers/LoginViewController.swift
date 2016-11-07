//
//  ViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/2/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton?.layer.cornerRadius = 10
        signInButton?.layer.borderWidth = 3
        signInButton?.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton?.layer.cornerRadius = 10
        signUpButton?.layer.borderWidth = 3
        signUpButton?.layer.borderColor = UIColor.whiteColor().CGColor
        addIconToTextFields()
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
    
    @IBAction func signinAction(sender: AnyObject) {
        loginService.signinBasic(emailTextField.text ?? "", password: passwordTextField.text ?? "", success: { (user) in
            print(user)
        }) { (message) in
            let alertValidateController = UIAlertController(title: "Message", message: "Invalid email/password combination", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            self.presentViewController(alertValidateController, animated: true) {
            }
        }
    }
}
