//
//  WordListSeervice.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/15/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
import Alamofire
class WordListService {
    let linkJSON = LinkJSON()
    
    func showWordList(option: String, categoryID: Int?, success: [Word] -> Void, failure: (String) -> Void) {
        let token = Defaults.authenToken.getString() ?? ""
        var parameter = [String: AnyObject]()
        if categoryID == nil {
            parameter = ["auth_token": token,
                         "option": option,
                         "per_page": "100"]
        } else {
            parameter = ["auth_token": token,
                         "category_id": categoryID!,
                         "option": option,
                         "per_page": "15"]
        }
        Alamofire.request(.GET, self.linkJSON.jsonWordList, parameters: parameter).responseJSON { response in
            if let JSON = response.result.value {
                var list = [Word]()
                guard let wordList = JSON["words"] as? [[String: AnyObject]] else {
                    if let message = JSON as? [String: String] {
                        failure(message["error"]!)
                    } else {
                        failure("failed to get message")
                    }
                    return
                }
                for item in wordList {
                    let word = item["content"] as? String ?? ""
                    var trueAnswer = ""
                    let answers = item["answers"] as? [[String: AnyObject]] ?? [[:]]
                    for answer in answers {
                        let testAnswer = answer["is_correct"] as? Bool ?? false
                        if testAnswer {
                            trueAnswer = answer["content"] as? String ?? ""
                        }
                    }
                    let wor = Word(word: word, answer: trueAnswer)
                    list.append(wor)
                }
                success(list)
            } else {
                failure("failed to get API")
            }
        }
    }
}
