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
    
    private static let USER_REPOSITORY_CELL_IDENTIFIER = "UserRepositoryCell"
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var aiRepositoriesLoading: UIActivityIndicatorView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblCreationDate: UILabel!
    @IBOutlet weak var vLocation: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var vCompany: UIView!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var vBio: UIView!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblRepositoryTableTitle: UILabel!
    @IBOutlet weak var lblNoRepositories: UILabel!
    @IBOutlet weak var tvUserData: UITableView!
    
    var presenter: UserProfilePresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showUserProfile(profile: Profile) {
        lblName.text = profile.name
        lblUsername.text = profile.username
        
        let dateFormatter = NSDateFormatter();
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM yyyy"
        lblCreationDate.text = "Member since \(dateFormatter.stringFromDate(profile.creationDate))"
        
        if let location = profile.location {
            lblLocation.text = location
            lblLocation.hidden = false
        } else {
            vLocation.hidden = true
        }
        
        if let company = profile.company {
            lblCompany.text = company
            lblCompany.hidden = false
        } else {
            vCompany.hidden = true
            
        }
        
        if let bio = profile.bio {
            lblBio.text = bio
            vBio.hidden = false
        } else {
            vBio.hidden = true
        }
    }
    
    func showUserAvatar(image: NSData) {
        imgAvatar.image = UIImage(data: image)
    }
    
    func refreshUserRepositories() {
        if let repositories = presenter.userRepositories where repositories.count > 0 {
            tvUserData.reloadData()
            lblRepositoryTableTitle.hidden = false
            lblNoRepositories.hidden = true
        } else {
            tvUserData.hidden = true
            lblRepositoryTableTitle.hidden = true
            lblNoRepositories.hidden = false
        }
    }
    
    func toggleLoading(visible: Bool) {
        if visible {
            aiLoading.startAnimating()
        } else {
            aiLoading.stopAnimating()
        }
    }
    
    func toggleRepositoriesLoading(visible: Bool) {
        if visible {
            aiRepositoriesLoading.startAnimating()
        } else {
            aiRepositoriesLoading.stopAnimating()
        }
    }
    
    func toggleRepositoriesTable(visible: Bool) {
        tvUserData.hidden = !visible
        lblRepositoryTableTitle.hidden = !visible
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userRepositories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(UserProfileViewController.USER_REPOSITORY_CELL_IDENTIFIER) as! UserRepositoryCell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! UserRepositoryCell).showRepository(presenter.userRepositories![indexPath.row])
    }
}