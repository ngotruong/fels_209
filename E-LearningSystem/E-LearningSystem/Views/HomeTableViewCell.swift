//
//  HomeTableViewCell.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var learnedWordLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var avataImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
