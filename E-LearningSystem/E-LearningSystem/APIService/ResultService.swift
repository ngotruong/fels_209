//
//  ResultService.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/17/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class ResultService: NSObject {
    func progress(data: [Section]) -> String {
        var number = 0
        for item in data {
            for anser in item.answers {
                if anser.isSelected {
                    if anser.isCorrect {
                        number += 1
                    }
                }
            }
        }
        return "\(number)/20"
    }
}
