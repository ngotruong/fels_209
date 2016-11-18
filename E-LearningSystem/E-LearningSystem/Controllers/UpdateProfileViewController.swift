//
//  UpdateProfileViewController.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/8/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var oldPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var retypePasswordTextfield: UITextField!
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    var user: User!
    var updateProfileService = UpdateProfileService()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addIconToTextFields()
        self.title = "Update Profile"
        self.emailTextfield.text = user.email
        self.emailTextfield.userInteractionEnabled = false
        self.emailTextfield.backgroundColor = UIColor.lightGrayColor()
        self.fullnameTextfield.text = user.fullname
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.frame = CGRect(x: (self.avataImageView.bounds.size.width/2) - 20, y: (self.avataImageView.bounds.size.height/2) - 20, width: 50, height: 50)
        avataImageView?.addSubview(activityIndicator)
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
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        chooseImageButton?.round(10, borderWith: 3, borderColor: UIColor.grayColor().CGColor)
        let buttonSave = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(updateAction))
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = buttonSave
        navigationItem.leftBarButtonItem = buttonCancel
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func updateAction() {
        LoadingIndicatorView.show(self.view, loadingText: "Updating...")
        let userUpdate = UserUpdate(name: fullnameTextfield?.text ?? "", email: emailTextfield?.text ?? "", pass: newPasswordTextfield?.text ?? "", confirmpass: retypePasswordTextfield?.text ?? "", avatar: avataImageView?.image ?? UIImage())
        updateProfileService.updateProfile(userUpdate, success: { (success) in
            if let profiles = self.storyboard?.instantiateViewControllerWithIdentifier("UserProfile") as? UserProfileViewController {
                profiles.user = User(user: success)
                if let activities = success["activities"] as? [[String: AnyObject]] {
                    profiles.lisActivities.appendContentsOf(activities)
                }
                self.navigationController?.pushViewController(profiles, animated: true)
            }
        }) { (failure) in
            let alertController = UIAlertController(title: "Message", message: failure, preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertController.addAction(OkButton)
            LoadingIndicatorView.hide()
            self.presentViewController(alertController, animated: true) {
            }
            
        }
    }
    
    @objc private func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Add icons to the Textfields
    private func addIconToTextFields() {
        let imageViewEmail = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewEmail.contentMode = UIViewContentMode.Center
        let imageEmail  = UIImage(named: "email_icon")
        imageViewEmail.image = imageEmail
        emailTextfield?.leftView = imageViewEmail
        emailTextfield?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewOldPassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewOldPassword.contentMode = UIViewContentMode.Center
        let imageOldPassword  = UIImage(named: "password_icon")
        imageViewOldPassword.image = imageOldPassword
        oldPasswordTextfield?.leftView = imageViewOldPassword
        oldPasswordTextfield?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewNewPassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewNewPassword.contentMode = UIViewContentMode.Center
        let imageNewPassword  = UIImage(named: "password_icon")
        imageViewNewPassword.image = imageNewPassword
        newPasswordTextfield?.leftView = imageViewNewPassword
        newPasswordTextfield?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewRetypePass = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewRetypePass.contentMode = UIViewContentMode.Center
        let imageConfirmPass  = UIImage(named: "password_icon")
        imageViewRetypePass.image = imageConfirmPass
        retypePasswordTextfield?.leftView = imageViewRetypePass
        retypePasswordTextfield?.leftViewMode = UITextFieldViewMode.Always
        
        let imageViewFullname = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageViewFullname.contentMode = UIViewContentMode.Center
        let imageFullname  = UIImage(named: "fullname_icon")
        imageViewFullname.image = imageFullname
        fullnameTextfield?.leftView = imageViewFullname
        fullnameTextfield?.leftViewMode = UITextFieldViewMode.Always
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        avataImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
