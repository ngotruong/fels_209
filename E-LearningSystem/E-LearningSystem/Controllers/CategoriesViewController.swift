//
//  CategoriesViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/11/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var listCategories = [[String: AnyObject]]()
    let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerNib(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK:  UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? CategoriesTableViewCell {
            cell.configCellWithContent(listCategories[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.size.height / 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
