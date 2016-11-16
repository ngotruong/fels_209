//
//  UserUpdate.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UserUpdate {
    var name: String
    var email: String
    var pass: String
    var confirmpass: String
    var avatar: UIImage
    
    init(name: String, email: String, pass: String, confirmpass: String, avatar: UIImage) {
        self.name = name
        self.email = email
        self.pass = pass
        self.confirmpass = confirmpass
        self.avatar = avatar
    }
}
