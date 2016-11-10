//
//  WordTableViewCell.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/15/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    func configureCell(word: Word) {
        self.wordLabel.text = word.word
        self.answerLabel.text = word.answer
    }
}
