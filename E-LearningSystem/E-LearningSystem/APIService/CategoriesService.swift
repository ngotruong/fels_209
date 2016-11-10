//
//  CategoriesService.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/11/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesService {
    
    let linkJson = LinkJSON()
    
    func getCategories(authToken: String, success: ([[String: AnyObject]]) -> Void, failure: ([String: String]) -> Void) {
        let parameter = [
            "auth_token": authToken
        ]
        Alamofire.request(.GET, linkJson.jsonCategories, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                guard let categories = JSON["categories"] as? [[String: AnyObject]] else {
                    if let message = JSON as? [String: String] {
                        failure(message)
                    } else {
                        failure(["message":"failed to get message"])
                    }
                    return
                }
                success(categories)
            } else {
                failure(["message":"failed to get API"])
            }
        }
    }
}
