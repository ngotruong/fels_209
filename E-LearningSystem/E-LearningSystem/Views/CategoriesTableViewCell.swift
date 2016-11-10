//
//  CategoriesTableViewCell.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/11/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var leanedWordLabel: UILabel!
    
    func configCellWithContent(cate: [String: AnyObject]?) {
        self.categoriesLabel?.numberOfLines = 0
        self.leanedWordLabel?.numberOfLines = 0
        if let categories = cate {
            self.categoriesLabel?.text = categories["name"] as? String
            if let cate = categories["learned_words"] as? Int {
                self.leanedWordLabel?.text = "Learned \(cate) words"
            }
            if let linkImage = categories["photo"] as? String {
                if let url = NSURL(string: linkImage) {
                    if let data = NSData(contentsOfURL: url) {
                        self.categoriesImageView?.image = UIImage(data: data)
                    } else {
                        self.categoriesImageView?.backgroundColor = UIColor.blueColor()
                    }
                }
            }
        }
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
}
