//
//  HomeTableViewCell.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/7/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeCreateLabel: UILabel!
    @IBOutlet weak var avataImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellWithContent(activities: [String: AnyObject]?) {
        self.timeCreateLabel?.numberOfLines = 0
        self.contentLabel?.numberOfLines = 0
        self.avataImageView?.backgroundColor = UIColor.orangeColor()
        if let activ = activities {
            self.contentLabel?.text = activ["content"] as? String
            self.timeCreateLabel?.text = activ["created_at"] as? String
        }
    }
}
