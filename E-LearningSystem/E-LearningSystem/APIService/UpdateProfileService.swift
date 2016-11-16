//
//  UpdateProfileService.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire
class UpdateProfileService {
    let linkJson = LinkJSON()
    
    func updateProfile(user: UserUpdate, success: ([String: AnyObject]) -> Void, failure: (String) -> Void) {
        let url = linkJson.updateProfile
        let imageData = UIImageJPEGRepresentation(user.avatar, 0.2)
        let imgStr = imageData?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let token =  Defaults.authenToken.getString() ?? ""
        var parameters = [String : AnyObject]()
        parameters["auth_token"] = token
        var users = [String : AnyObject]()
        users["name"] = user.name
        users["email"] = user.email
        users["avatar"] = imgStr ?? ""
        users["password"] = user.pass
        users["password_confirmation"] = user.confirmpass
        parameters["user"] = users
        let fdata = MultipartFormData()
        self.buildMultpathDataFromDict(fdata, parameters: parameters)
        let headers = ["Authorization": token, "Content-Type":"application/x-www-form-urlencoded"]
        let manager = Alamofire.Manager.sharedInstance
        manager.session.configuration.timeoutIntervalForRequest = 60
        manager.session.configuration.timeoutIntervalForResource = 60
        manager.request(.PATCH, url, parameters: parameters, encoding: ParameterEncoding.URL, headers: headers).responseJSON(completionHandler: { (response) in
            if let JSON = response.result.value {
                guard let user = JSON["user"] as? [String: AnyObject] else {
                    if let message = JSON["message"] as? [String: String] {
                        let failed = message.values.first ?? ""
                        failure(failed)
                    } else {
                        failure("failed to get message")
                    }
                    return 
                }
                success(user)
            } else {
                failure("failed to connect to Server")
            }
        })
    }
    
    func buildMultpathDataFromDict(multipartFormData: MultipartFormData, parameters: [String: AnyObject]) {
        for (key, value) in parameters {
            if let array = value as? [[String : AnyObject]] {
                for dict in array {
                    for (key2, value2) in dict {
                        let newKey = key + "[][\(key2)]"
                        var content = ""
                        if value2 is String {
                            content = value2 as? String ?? ""
                        } else {
                            content = String(value2)
                        }
                        if let data = content.dataUsingEncoding(NSUTF8StringEncoding) {
                            multipartFormData.appendBodyPart(data: data, name: newKey)
                        }
                    }
                }
            } else {
                if let dictValues = value as? [String : AnyObject] {
                    self.buildMultpathDataFromDict(multipartFormData, parameters: dictValues)
                } else {
                    if let str = value as? String {
                        if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                            multipartFormData.appendBodyPart(data: data, name: key)
                        }
                    } else {
                        if let data = value as? NSData {
                            multipartFormData.appendBodyPart(data: data, name: key)
                        } else {
                            let str = String(value)
                            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                                multipartFormData.appendBodyPart(data: data, name: key)
                            }
                        }
                    }
                }
            }
        }
    }

}
