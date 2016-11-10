//
//  DropdownCell.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class DropdownCell: UITableViewCell {
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.textLabel?.textAlignment = NSTextAlignment.Center
        self.textLabel?.numberOfLines = 0    }
}
