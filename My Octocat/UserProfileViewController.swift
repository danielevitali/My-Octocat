//
//  ProfileViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, UserProfileViewContract, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var tvUserData: UITableView!
    
    var presenter: UserProfilePresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    //TODO: show profile
    func showUserProfile(profile: Profile) {
        tvUserData.reloadData()
    }
    
    func showUserAvatar(image: NSData) {
        let profileCell = tvUserData.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)) as! ProfileCell
        profileCell.showAvatar(image)
    }
    
    //TODO: show repositories
    func showUserRepositories(repositories: [Repository]) {
        tvUserData.reloadData()
    }
    
    func toggleLoading(visible: Bool) {
        if visible {
            aiLoading.startAnimating()
        } else {
            aiLoading.stopAnimating()
        }
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.user.profile != nil {
            return 1 + (presenter.user.repositories?.count ?? 0)
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileCell
            profileCell.showProfile(presenter.user.profile!)
            return profileCell
        }
        let repositoryCell = tableView.dequeueReusableCellWithIdentifier("UserRepositoryCell") as! UserRepositoryCell
        repositoryCell.showRepository(presenter.user.repositories![indexPath.row - 1])
        return repositoryCell
    }
    
}