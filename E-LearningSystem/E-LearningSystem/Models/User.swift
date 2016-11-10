//
//  UserProfile.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/9/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class User {
    var fullname: String
    var email: String
    var learnedWords: Int
    var avatar: String
    var activities: [[String : AnyObject]]
    
    init(fullname: String, email: String, learnedWords: Int, avatar: String, activities: [[String: AnyObject]]) {
        self.fullname = fullname
        self.email = email
        self.learnedWords = learnedWords
        self.avatar = avatar
        self.activities = activities
    }
    
    convenience init(user: [String : AnyObject]) {
        self.init(fullname: user["name"] as? String ?? "", email: user["email"] as? String ?? "", learnedWords: user["learned_words"] as? Int ?? 0, avatar: user["avatar"] as? String ?? "", activities: user["activities"] as? [[String : AnyObject]] ?? [["": ""]])
    }
}
