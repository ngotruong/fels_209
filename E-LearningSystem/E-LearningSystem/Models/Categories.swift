//
//  Categories.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class Categories: NSObject {
    var learnedWord: Int
    var name: String
    
    init(learnedWord: Int, name: String) {
        self.learnedWord = learnedWord
        self.name = name
    }
}
