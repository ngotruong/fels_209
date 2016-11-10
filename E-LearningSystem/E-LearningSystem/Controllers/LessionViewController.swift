//
//  LessionViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class LessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var sectionData = [Section]()
    let cellIdentifier = "Cell"
    var string = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        let buttonSave = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(finishedAction))
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = buttonSave
        navigationItem.leftBarButtonItem = buttonCancel
        tableView?.registerNib(UINib(nibName: "LessionTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc private func finishedAction() {
        if let results = self.storyboard?.instantiateViewControllerWithIdentifier("Result") as? ResultViewController {
            results.result.appendContentsOf(sectionData)
            results.title = string
            let navController = UINavigationController(rootViewController: results)
            self.presentViewController(navController, animated:true, completion: nil)
        }
    }
    
    @objc private func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:  UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section + 1). " + sectionData[section].words
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView?.dequeueReusableCellWithIdentifier(cellIdentifier) as? LessionTableViewCell {
            let answers = sectionData[indexPath.section].answers[indexPath.row]
            cell.configCellWithContent(answers)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        if section < sectionData.count {
            if row < sectionData[section].answers.count {
                let sections = sectionData[indexPath.section]
                sections.reset()
                let info = sectionData[section].answers[row]
                let previousSelected = info.isSelected
                info.isSelected = !previousSelected
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
            }
        }
    }
}
