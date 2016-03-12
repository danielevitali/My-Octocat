//
//  ProfileViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, ProfileViewContract {
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    var presenter: ProfilePresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showUserProfile(profile: Profile) {
        lblName.text = profile.name
        lblUsername.text = profile.username
        if let avatarUrl = profile.avatarUrl {
            imgAvatar.image = UIImage(named: avatarUrl)
        }
    }
    
    func showLoading() {
        aiLoading.startAnimating()
    }
    
    func hideLoading() {
        aiLoading.stopAnimating()
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
}