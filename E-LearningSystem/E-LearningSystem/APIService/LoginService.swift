//
//  LoginService.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
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
    func signinUsingFB(success: (User) -> Void, failure: ([String: String]) -> Void) {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).startWithCompletionHandler { (connection, result, error) in
            if let userFb = result as? [String: String] {
                let parameter = ["user": [
                    "name": userFb["name"] ?? "",
                    "uid": userFb["id"] ?? "",
                    "email": userFb["email"] ?? "",
                    "remote_avatar_url": "https://graph.facebook.com/\(userFb["id"] ?? "687581134725022")/picture?type=large&return_ssl_resources=1",
                    "user[provider]": "facebook"
                    ]]
                Alamofire.request(.POST, "https://manh-nt.herokuapp.com/auths.json", parameters: parameter).responseJSON { response in
                    if let JSON = response.result.value {
                        guard let user = JSON["user"] as? [String: AnyObject] else {
                            if let message = JSON as? [String: String] {
                                failure(message)
                            } else {
                                failure(["message":"failed to get message"])
                            }
                            return
                        }
                        let users = User(fullname: user["name"] as? String ?? "", email: user["email"] as? String ?? "", learnedWords: user["learned_words"] as? Int ?? 0, avatar: user["avatar"] as? String ?? "", activities: user["activities"] as? [[String : AnyObject]] ?? [["": ""]])
                        success(users)
                    } else {
                        failure(["message":"failed to get API"])
                    }
                }
            }
        }
    }
}
