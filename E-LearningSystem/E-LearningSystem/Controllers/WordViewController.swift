//
//  WordViewController.swift
//  E-LearningSystem
//
//  Created by Phùng Tùng on 11/15/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit
class WordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var answerTableDropdown: UITableView?
    var wordTableView: UITableView?
    var wordFilterButton: UIButton?
    var answerFilterButton: UIButton?
    let cellIdentifier = "cell"
    let cellIdentifier1 = "cell1"
    var wordlistService = WordListService()
    var token: String = ""
    var listWord = [Word]()
    var listCategories = [[String: AnyObject]]()
    let anserDropdowList = ["All", "Learn", "Not Learn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Word List"
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.registerNib(UINib(nibName: "WordTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        setupDropdownMenu()
        LoadingIndicatorView.show(self.view, loadingText: "Loading")
        wordlistService.showWordList("all_word", categoryID: -1, success: { (success) in
            for word in success {
                self.listWord.append(word)
            }
            self.tableview?.reloadData()
            LoadingIndicatorView.hide()
        }) { (failure) in
            let alertController = UIAlertController(title: "Message", message: failure, preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertController.addAction(OkButton)
            LoadingIndicatorView.hide()
            self.presentViewController(alertController, animated: true) {
            }
        }
    }
    
    func setupDropdownMenu() {
        weak var weakSelf = self
        wordFilterButton = UIButton(type: .System)
        wordFilterButton?.backgroundColor = UIColor.grayColor()
        wordFilterButton?.frame = CGRect(x: 2, y: 65, width: (view.frame.width - 4)/2, height: 59)
        wordFilterButton?.setTitle("All", forState: .Normal)
        wordFilterButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        wordFilterButton?.addTarget(self, action: #selector(wordFilterAction), forControlEvents: .TouchUpInside)
        view.addSubview(wordFilterButton!)
        
        answerFilterButton = UIButton(type: .System)
        answerFilterButton?.backgroundColor = UIColor.grayColor()
        answerFilterButton?.frame = CGRect(x: 2 + (view.frame.width/2), y: 65, width: (view.frame.width - 6)/2, height: 59)
        answerFilterButton?.setTitle("All", forState: .Normal)
        answerFilterButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        answerFilterButton?.addTarget(self, action: #selector(answerFilterAction), forControlEvents: .TouchUpInside)
        view.addSubview(answerFilterButton!)
        
        wordTableView = UITableView()
        wordTableView?.delegate = weakSelf
        wordTableView?.dataSource = weakSelf
        wordTableView?.frame = CGRect(x: 2, y: 65, width: (view.frame.width - 4)/2, height: 132)
        wordTableView?.hidden = true
        wordTableView?.registerClass(DropdownCell.self, forCellReuseIdentifier: "wordDropdow")
        view.addSubview(wordTableView!)
        
        answerTableDropdown = UITableView()
        answerTableDropdown?.delegate = weakSelf
        answerTableDropdown?.dataSource = weakSelf
        answerTableDropdown?.frame = CGRect(x: 2 + (view.frame.width/2), y: 65, width: (view.frame.width - 6)/2, height: 132)
        answerTableDropdown?.hidden = true
        answerTableDropdown?.registerClass(DropdownCell.self, forCellReuseIdentifier: "answerDropdow")
        view.addSubview(answerTableDropdown!)
    }
    
    @objc func answerFilterAction() {
        self.answerTableDropdown?.hidden = false
    }
    
    @objc func wordFilterAction() {
        self.wordTableView?.hidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.contentInset.top = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableview {
            return listWord.count
        } else if tableView == self.wordTableView {
            return listCategories.count
        } else {
            return anserDropdowList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.wordTableView == tableView {
            if let cell = tableView.dequeueReusableCellWithIdentifier("wordDropdow", forIndexPath: indexPath) as? DropdownCell {
                let cate = listCategories[indexPath.row]
                cell.textLabel?.text = cate["name"] as? String
                return cell
            }
            return UITableViewCell()
        }
        if tableView == self.answerTableDropdown {
            if let cell = tableView.dequeueReusableCellWithIdentifier("answerDropdow", forIndexPath: indexPath) as? DropdownCell {
                cell.textLabel?.text = anserDropdowList[indexPath.row]
                return cell
            }
            return UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? WordTableViewCell {
            cell.configureCell(listWord[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.wordTableView {
            let category = listCategories[indexPath.row]
            self.wordFilterButton?.setTitle(category["name"] as? String ?? "", forState: .Normal)
            self.wordTableView?.hidden = true
            LoadingIndicatorView.show(self.view, loadingText: "Loading")
            wordlistService.showWordList("all_word", categoryID: category["id"] as? Int ?? nil, success: { (success) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.listWord.removeAll()
                    self.listWord.appendContentsOf(success)
                    self.tableview.reloadData()
                    LoadingIndicatorView.hide()
                })
                }, failure: { (message) in
                    let alerController = UIAlertController(title: "Message", message: message, preferredStyle: .Alert)
                    let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                    alerController.addAction(OkButton)
                    LoadingIndicatorView.hide()
                    self.presentViewController(alerController, animated: true) {
                    }
            })
        }
        if tableView == self.answerTableDropdown {
            self.answerFilterButton?.setTitle(anserDropdowList[indexPath.row], forState: .Normal)
            self.answerTableDropdown?.hidden = true
            LoadingIndicatorView.show(self.view, loadingText: "Loading")
            wordlistService.showWordList(anserDropdowList[indexPath.row], categoryID: nil, success: { (success) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.listWord.removeAll()
                    self.listWord.appendContentsOf(success)
                    self.tableview.reloadData()
                    LoadingIndicatorView.hide()
                })
                }, failure: { (message) in
                    let alerController = UIAlertController(title: "Message", message: message, preferredStyle: .Alert)
                    let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                    alerController.addAction(OkButton)
                    LoadingIndicatorView.hide()
                    self.presentViewController(alerController, animated: true) {
                    }
            })
        }
    }
}
