//
//  ViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/2/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 3
        signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        addIconToTextFields()
    }
    
    @IBAction func signInBasic(sender: AnyObject) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://manh-nt.herokuapp.com/login.json")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let postString = "session[email]=\(emailTextField.text!)&session[password]=\(passwordTextField.text!)&session[remember_me]=1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        session.dataTaskWithRequest(request) {data, response, error in
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]
                let profile = (self.storyboard?.instantiateViewControllerWithIdentifier("UserProfile") as? UserProfile)!
                if let user = json?["user"] as? [String: AnyObject] {
//                    let learnedWord = user["learned_words"]
                    if let name = user["name"] as? String, learnedWord = user["learned_words"] as? Int, email = user["email"] as? String, activities = user["activities"] as? [String: AnyObject] {
                        dispatch_async(dispatch_get_main_queue(), {
                            profile.fullname = name
                            profile.learnedWord = learnedWord
                            profile.email = email
                            profile.listActivities = activities
                            self.navigationController?.pushViewController(profile, animated: true)
                        })
                    }
                }
            } catch let jsonError {
                print("Error with Json: \(jsonError)")
            }
            }.resume()
    }
    
    @IBAction func googlePlusButtonTouchUpInside(sender: AnyObject) {
        print("abc abc")
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: - Google SignIn Delegate
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if error == nil {
            //            let userId = user.userID
            //            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            let email = user.profile.email
            let profile = (self.storyboard?.instantiateViewControllerWithIdentifier("UserProfile") as? UserProfile)!
            let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
            appDelegate.window?.rootViewController = profile
            profile.emailLabel?.text = email
            profile.fullnameLabel?.text = fullName
            if user.profile.hasImage {
                let pic = user.profile.imageURLWithDimension(100)
                if let data = NSData(contentsOfURL: pic) {
                    profile.avataImageView.image = UIImage(data: data)
                }
            }
        } else {
            print("error")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!,
                withError error: NSError!) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            "ToggleAuthUINotification",
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
    
    // MARK: - Add icons to the Textfields
    private func addIconToTextFields() {
        let imageViewEmail = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewEmail.contentMode = UIViewContentMode.Center
        let imageEmail  = UIImage(named: "email_icon")
        imageViewEmail.image = imageEmail
        emailTextField.leftView = imageViewEmail
        emailTextField.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewPassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewPassword.contentMode = UIViewContentMode.Center
        let imagePassword  = UIImage(named: "password_icon")
        imageViewPassword.image = imagePassword
        passwordTextField.leftView = imageViewPassword
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
    }
}
