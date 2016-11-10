//
//  Answers.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class Answers: NSObject {
    var content = ""
    var idAnswer = 0
    var isCorrect = false
    var isSelected = false
    
    override init() {
        super.init()
    }
    
    convenience init(answers: [String: AnyObject]) {
        self.init()
        let content = answers["content"] as? String
        let id = answers["id"] as? Int
        let isCorrect = answers["is_correct"] as? Bool
        self.content = content ?? ""
        self.idAnswer = id ?? 0
        self.isCorrect = isCorrect ?? false
    }
    
    func reset() {
        isSelected = false
    }
}
