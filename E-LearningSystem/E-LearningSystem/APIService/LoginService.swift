//
//  LoginService.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire
class LoginService {
    
    func signinBasic(email: String, password: String, success: ([String: AnyObject]) -> Void, failure: ([String: String]) -> Void) {
        let parameter = ["session": [
            "email": email,
            "password": password,
            "remember_me": "1"]
        ]
        
        Alamofire.request(.POST, "https://manh-nt.herokuapp.com/login.json", parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let userApp = JSON["user"] as? [String: AnyObject] else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(userApp)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }
}
