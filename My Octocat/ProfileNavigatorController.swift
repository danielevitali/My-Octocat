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
        
        let editButton = UIBarButtonItem(image: UIImage(named: "icon pencil"), style: .Done, target: self, action: "onEditClick")
        let logoutButton = UIBarButtonItem(image: UIImage(named: "icon logout"), style: .Done, target: self, action: "onLogoutClick")
        navigationItem.rightBarButtonItems = [editButton, logoutButton]
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