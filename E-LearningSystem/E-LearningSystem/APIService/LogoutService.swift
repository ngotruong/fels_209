//
//  LogoutService.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire

class LogoutService: NSObject {
    let linkJson = LinkJSON()
    
    func getLogOut(authToken: String, success: (String) -> Void, failure: ([String: String]) -> Void) {
        let parameter = [
            "auth_token": authToken
        ]
        Alamofire.request(.DELETE, linkJson.jsonLogout, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let mess = JSON["message"] as? String else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(mess)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }
}
