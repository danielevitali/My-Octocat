//
//  ProfileViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, UserProfileViewContract {
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    var presenter: UserProfilePresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    //TODO: show profile
    func showUserProfile(profile: Profile) {
        
    }
    
    //TODO: show repositories
    func showUserRepositories(repositories: [Repository]) {
        
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
    
}