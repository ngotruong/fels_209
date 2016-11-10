//
//  ResultTableViewCell.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/17/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var anwerImageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    func configCellWithContent(section: Section) {
        self.wordLabel?.text = section.words + " :"
        self.answerLabel?.text = "Not answer"
        self.answerLabel?.textColor = UIColor.redColor()
        for anser in section.answers {
            if anser.isSelected {
                self.answerLabel?.text = anser.content
                self.answerLabel?.textColor = UIColor.blackColor()
                if anser.isCorrect {
                    self.anwerImageView?.image = UIImage(named: "true_icon")
                } else {
                    self.anwerImageView?.image = UIImage(named: "false_icon")
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.answerLabel?.text = ""
        self.anwerImageView?.image = nil
    }
}
