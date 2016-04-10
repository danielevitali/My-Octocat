//
//  RepositoryViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class RepositoryViewController: UIViewController, RepositoryViewContract, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: RepositoryPresenterContract!
    
    @IBOutlet weak var tblCommits: UITableView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblNoCommits: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showRepositoryWebButton = UIButton(type: .Custom)
        showRepositoryWebButton.setImage(UIImage(named: "icon web")!, forState: .Normal)
        showRepositoryWebButton.frame = CGRectMake(0, 0, 30, 30)
        showRepositoryWebButton.addTarget(self, action: #selector(onShowRepositoryOnWebClick), forControlEvents: .TouchUpInside)
        let showRepositoryWebBarButton = UIBarButtonItem(customView: showRepositoryWebButton)
        
        navigationItem.setRightBarButtonItem(showRepositoryWebBarButton, animated: false)
        
        presenter.viewDidLoad()
    }
    
    func onShowRepositoryOnWebClick() {
        presenter.onShowRepositoryOnWebClick()
    }
    
    func showRepositoryTitle(title: String) {
        self.title = title
    }
    
    func toggleLoading(visible: Bool) {
        if visible {
            aiLoading.startAnimating()
        } else {
            aiLoading.stopAnimating()
        }
    }
    
    func toggleNoCommitFound(visible: Bool) {
        lblNoCommits.hidden = !visible
    }
    
    func toggleCommitList(visible: Bool) {
        tblCommits.hidden = !visible
    }
    
    func reloadCommits() {
        tblCommits.reloadData()
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showCommit(url: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func showRepositoryOnWeb(url: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repo.commits?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommitCell", forIndexPath: indexPath) as! CommitCell
        cell.showCommit(presenter.repo.commits![indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presenter.onCommitClick(indexPath)
    }
    
}