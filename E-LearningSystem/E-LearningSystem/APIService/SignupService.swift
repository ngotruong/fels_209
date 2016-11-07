//
//  SignupService.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire
class SignupService {
    
    func handleLogicSignup(sigupUser: SignupUser, success: ([String: AnyObject]) -> Void, validate: (String) -> Void, failure: (String) -> Void) {
        let parameter = ["user": [
            "name": sigupUser.name,
            "email": sigupUser.email,
            "password": sigupUser.password,
            "password_confirmation": sigupUser.passwordConfirmation
            ]]
        Alamofire.request(.POST, "https://manh-nt.herokuapp.com/users.json", parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                if let userApp = JSON["user"] as? [String: AnyObject] {
                    success(userApp)
                } else {
                    if let message = JSON as? [String: AnyObject] {
                        validate(self.formatMessage(message))
                    } else {
                        failure("failed to get message")
                    }
                }
            } else {
                failure("failed to get API")
            }
        }
    }
    
    // MARK: - Format message get from server
    func formatMessage(message: ([String: AnyObject])) -> String {
        var email = "Email: "
        var pass = "Password: "
        var name = "Name: "
        var passwordConfirmation = "Confirm Password: "
        if let mess = message["message"] as? [String: AnyObject] {
            if let emailArr = mess["email"] as? [String] {
                for temporary in emailArr {
                    email += "\(temporary), "
                }
                email += "\n"
            } else {
                email = ""
            }
            if let passArr = mess["password"] as? [String] {
                for temporary in passArr {
                    pass += "\(temporary)"
                }
                pass += "\n"
            } else {
                pass = ""
            }
            if let nameArr = mess["name"] as? [String] {
                for temporary in nameArr {
                    name += "\(temporary)"
                }
                name += "\n"
            } else {
                name = ""
            }
            if let passwordConfirmationArr = mess["password_confirmation"] as? [String] {
                for temporary in passwordConfirmationArr {
                    passwordConfirmation += "\(temporary)"
                }
                passwordConfirmation += "\n"
            } else {
                passwordConfirmation = ""
            }
        }
        return "\(email)\(pass)\(name)\(passwordConfirmation)"
    }
}
