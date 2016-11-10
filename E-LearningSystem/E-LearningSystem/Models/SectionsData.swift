//
//  SectionsData.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

struct Section {
    var words = ""
    var answers = [Answers]()
    
    init(words: String, answers: [[String: AnyObject]]) {
        self.words = "Word : " + words
        for dictInfo in answers {
            let answerInfo = Answers(answers: dictInfo)
            self.answers.append(answerInfo)
        }
    }
    
    func reset() {
        for info in answers {
            info.reset()
        }
    }
}

class SectionsData {
    func getSectionsFromData(wordList: [[String: AnyObject]]) -> [Section] {
        var sectionsArray = [Section]()
        for word in wordList {
            let abc = Section(words: word["content"] as? String ?? "", answers: word["answers"] as? [[String: AnyObject]] ?? [[:]])
            sectionsArray.append(abc)
        }
        return sectionsArray
    }
}
