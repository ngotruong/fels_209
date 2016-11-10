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
    let linkJson = LinkJSON()

    func signinBasic(email: String, password: String, success: ([String: AnyObject]) -> Void, failure: ([String: String]) -> Void) {
        let parameter = ["session": [
            "email": email,
            "password": password,
            "remember_me": "1"]
        ]
        Alamofire.request(.POST, self.linkJson.jsonSignInBasic, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let user = JSON["user"] as? [String: AnyObject] else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(user)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }
    
    func signinUsingFB(success: ([String: AnyObject]) -> Void, failure: ([String: String]) -> Void) {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).startWithCompletionHandler { (connection, result, error) in
            if let userFb = result as? [String: String] {
                let parameter = ["user": [
                    "name": userFb["name"] ?? "",
                    "uid": userFb["id"] ?? "",
                    "email": userFb["email"] ?? "",
                    "remote_avatar_url": "https://graph.facebook.com/\(userFb["id"] ?? "687581134725022")/picture?type=large&return_ssl_resources=1",
                    "user[provider]": "facebook"
                    ]]
                Alamofire.request(.POST, self.linkJson.jsonSignInAuths, parameters: parameter).responseJSON { response in
                    if let JSON = response.result.value {
                        guard let user = JSON["user"] as? [String: AnyObject] else {
                            if let message = JSON as? [String: String] {
                                failure(message)
                            } else {
                                failure(["message":"failed to get message"])
                            }
                            return
                        }
                        success(user)
                    } else {
                        failure(["message":"failed to get API"])
                    }
                }
            }
        }
    }
    
    func signInWithGoogle(userGooglePlus: UserGooglePlus, success: ([String: AnyObject]) -> Void, failure: ([String: String]) -> Void) {
        var userDict = [
            "name": userGooglePlus.name,
            "uid": userGooglePlus.uid,
            "email": userGooglePlus.email,
            "provider": userGooglePlus.provider,
            ]
        if let avataURL = userGooglePlus.remoteAvatarUrl {
            userDict["remote_avatar_url"] = avataURL.absoluteString
        }
        let parameter = ["user": userDict]
        Alamofire.request(.POST, self.linkJson.jsonSignInAuths, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let user = JSON["user"] as? [String: AnyObject] else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(user)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }  
}
