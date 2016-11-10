//
//  DetailLessionViewController.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

class DetailLessionViewController: UIViewController {
    var categories: Categories!
    var lessionService = LessionService()
    var user: User!
    
    @IBOutlet weak var learnedWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categories.name
        self.learnedWordLabel?.text = "Learned \(categories.learnedWord) words"
    }
    
    @IBAction func startLession(sender: AnyObject) {
        weak var weakSelf = self
        LoadingIndicatorView.show(self.view, loadingText: "Loading")
        lessionService.getLession(user.authToken, success: { (listLession) in
            if let lession = self.storyboard?.instantiateViewControllerWithIdentifier("Lession") as? LessionViewController {
                if let words = listLession["words"] as? [[String: AnyObject]] ?? [["": ""]] {
                    let section = SectionsData()
                    lession.sectionData.appendContentsOf(section.getSectionsFromData(words))
                }
                lession.string = self.categories.name
                let navController = UINavigationController(rootViewController: lession)
                LoadingIndicatorView.hide()
                self.presentViewController(navController, animated:true, completion: nil)
            }
        }) { (message) in
            LoadingIndicatorView.hide()
            let alertValidateController = UIAlertController(title: "Message", message: message["message"] ?? "", preferredStyle: .Alert)
            let OkButton = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertValidateController.addAction(OkButton)
            weakSelf?.presentViewController(alertValidateController, animated: true) {
            }
        }
    }
}
