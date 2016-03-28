//
//  ProfileNavigatorController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus

class UserProfileNavigatorController: UINavigationController, UserProfileNavigatorViewContract {
    
    var presenter: UserProfileNavigatorPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showUserProfile() {
        Router.showUserProfileInNavigatorController(self)
        
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "icon pencil"), forState: .Normal)
        editButton.frame = CGRectMake(0, 0, 30, 30)
        editButton.addTarget(self, action: #selector(UserProfileNavigatorController.onEditClick), forControlEvents: .TouchUpInside)
        let editBarButton = UIBarButtonItem(customView: editButton)
        
        let logoutButton = UIButton()
        logoutButton.setImage(UIImage(named: "icon logout"), forState: .Normal)
        logoutButton.frame = CGRectMake(0, 0, 30, 30)
        logoutButton.addTarget(self, action: #selector(UserProfileNavigatorController.onLogoutClick), forControlEvents: .TouchUpInside)
        let logoutBarButton = UIBarButtonItem(customView: editButton)

        navigationItem.setRightBarButtonItems([editBarButton, logoutBarButton], animated: false)
    }
    
    func onLogoutClick() {
        presenter.onLogoutClick()
    }
    
    func onEditClick() {
        presenter.onEditClick()
    }
    
    func showEditProfile(user: User) {
        Router.showEditProfile(self, user: user)
    }
    
}