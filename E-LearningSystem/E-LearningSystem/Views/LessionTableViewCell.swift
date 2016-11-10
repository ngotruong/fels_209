//
//  LessionTableViewCell.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class LessionTableViewCell: UITableViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    
    func configCellWithContent(answer: Answers) {
        print("did select \(answer.isSelected ? "YEs" : "No")")
        self.answerLabel?.text = answer.content
        self.accessoryType = answer.isSelected ? .Checkmark : .None
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .None
        self.answerLabel?.text = ""
    }
}
