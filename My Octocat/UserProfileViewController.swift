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
    
    private static let USER_PROFILE_CELL_IDENTIFIER = "UserProfileCell"
    private static let USER_REPOSITORY_CELL_IDENTIFIER = "UserRepositoryCell"
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var tvUserData: UITableView!
    
    var presenter: UserProfilePresenterContract!
    lazy var userProfileCell = UINib(nibName: UserProfileViewController.USER_PROFILE_CELL_IDENTIFIER, bundle: nil).instantiateWithOwner(nil, options: nil).first as! UserProfileCell
    lazy var userRepositoryCell = UINib(nibName: UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER, bundle: nil).instantiateWithOwner(nil, options: nil).first as! UserRepositoryCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showUserProfile(profile: Profile) {
        tvUserData.reloadData()
    }
    
    func showUserAvatar(image: NSData) {
        if let profileCell = tvUserData.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)) as? UserProfileCell {
            profileCell.showAvatar(image)
        }
    }
    
    func showUserRepositories(repositories: [Repository]) {
        //tvUserData.reloadData()
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
            var userProfileCell = tableView.dequeueReusableCellWithIdentifier(UserProfileViewController.USER_PROFILE_CELL_IDENTIFIER) as? UserProfileCell
            if userProfileCell == nil {
                tableView.registerNib(UINib.init(nibName: UserProfileViewController.USER_PROFILE_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: UserProfileViewController.USER_PROFILE_CELL_IDENTIFIER)
                userProfileCell = tableView.dequeueReusableCellWithIdentifier(UserProfileViewController.USER_PROFILE_CELL_IDENTIFIER) as? UserProfileCell
            }
            return userProfileCell!
        }
        var userRepositoryCell = tableView.dequeueReusableCellWithIdentifier(UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER) as? UserRepositoryCell
        if userRepositoryCell == nil {
            tableView.registerNib(UINib.init(nibName: UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER)
            userRepositoryCell = tableView.dequeueReusableCellWithIdentifier(UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER) as? UserRepositoryCell
        }
        return userRepositoryCell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let userProfileCell = cell as? UserProfileCell {
            userProfileCell.showProfile(presenter.user.profile!)
        } else if let userRepositoryCell = cell as? UserRepositoryCell {
            userRepositoryCell.showRepository(presenter.user.repositories![indexPath.row - 1])
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let profile = presenter.user.profile where indexPath.row == 0 {
            userProfileCell.showProfile(profile)
            userProfileCell.setNeedsLayout()
            userProfileCell.layoutIfNeeded()
            let size = userProfileCell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height
        } else if let repositories = presenter.user.repositories where indexPath.row > 0 {
            userRepositoryCell.showRepository(repositories[indexPath.row - 1])
            userRepositoryCell.setNeedsLayout()
            userRepositoryCell.layoutIfNeeded()
            let size = userRepositoryCell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height
        }
        return 0
    }}