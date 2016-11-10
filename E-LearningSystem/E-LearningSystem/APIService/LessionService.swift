//
//  lessionService.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire

class LessionService: NSObject {
    let linkJson = LinkJSON()
    
    func getLession(authToken: String, success: ([String: AnyObject]) -> Void, failure: ([String: String]) -> Void) {
        let parameter = [
            "auth_token": authToken
        ]
        Alamofire.request(.POST, linkJson.jsonLession, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let lession = JSON["lesson"] as? [String: AnyObject] else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(lession)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }
}
