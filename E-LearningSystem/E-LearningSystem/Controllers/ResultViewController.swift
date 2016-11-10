//
//  ResultViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lessionLabel: UILabel!
    @IBOutlet weak var leanedWordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var result = [Section]()
    let cellIdentifier = "Cell"
    var resultService = ResultService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        self.leanedWordLabel?.text = resultService.progress(result)
        let buttonDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(doneLession))
        navigationItem.rightBarButtonItem = buttonDone
        tableView?.registerNib(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc private func doneLession() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView?.contentInset.top = 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ResultTableViewCell {
            let word = result[indexPath.row]
            cell.configCellWithContent(word)
            return cell
        }
        return UITableViewCell()
    }
}
