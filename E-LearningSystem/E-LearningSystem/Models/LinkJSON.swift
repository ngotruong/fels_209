//
//  linkJSON.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

struct LinkJSON {
    let jsonSignInBasic = "https://manh-nt.herokuapp.com/login.json"
    let jsonSignInAuths = "https://manh-nt.herokuapp.com/auths.json"
    let jsonSignUp = "https://manh-nt.herokuapp.com/users.json"
    let jsonCategories = "https://manh-nt.herokuapp.com/categories.json"
    let jsonLession = "https://manh-nt.herokuapp.com/categories/1/lessons.json"
    let jsonLogout = "https://manh-nt.herokuapp.com/logout.json"
    let jsonWordList = "https://manh-nt.herokuapp.com/words.json"
    let jsonUpdateProfile = "https://manh-nt.herokuapp.com/users/" + (Defaults.userId.getString() ?? "") + ".json"
}
