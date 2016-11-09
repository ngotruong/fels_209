//
//  SignupUser.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class SignupUser {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
    init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
