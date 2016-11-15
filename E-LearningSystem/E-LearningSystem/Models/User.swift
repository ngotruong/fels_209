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
    var authToken: String
    
    init(fullname: String, email: String, learnedWords: Int, avatar: String, authToken: String) {
        self.fullname = fullname
        self.email = email
        self.learnedWords = learnedWords
        self.avatar = avatar
        self.authToken = authToken
    }
    
    convenience init(user: [String: AnyObject]) {
        if let token = user["auth_token"] as? String {
            Defaults.authenToken.set(token)
        }
        if let id = user["id"] as? Int {
            Defaults.userId.set("\(id)")
        }
        self.init(fullname: user["name"] as? String ?? "", email: user["email"] as? String ?? "", learnedWords: user["learned_words"] as? Int ?? 0, avatar: user["avatar"] as? String ?? "", authToken: user["auth_token"] as? String ?? "")
    }
}
