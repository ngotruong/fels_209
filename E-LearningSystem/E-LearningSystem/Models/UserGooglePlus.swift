//
//  UserGooglePlus.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/10/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class UserGooglePlus {
    var name: String
    var uid: String
    var email: String
    var remoteAvatarUrl: NSURL?
    var provider: String
    
    init(name: String, uid: String, email: String, remoteAvatarUrl: NSURL?, provider: String) {
        self.name = name
        self.uid = uid
        self.email = email
        self.remoteAvatarUrl = remoteAvatarUrl
        self.provider = provider
    }
}
