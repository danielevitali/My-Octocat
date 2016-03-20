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

class ProfileNavigatorController: UINavigationController, ProfileNavigatorViewContract {
    
    var presenter: ProfileNavigatorPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func showProfile(user: User) {
        Router.replaceAuthenticationWithProfile(self, user: user)
        navigationController?.navigationItem.rightBarButtonItem = nil
    }
    
    func showLogin() {
        Router.replaceProfileWithAuthentication(self)
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .Done, target: self, action: "onLogoutClick")
        logoutButton.image = UIImage(named: "icon logout")
        let editProfileButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "onEditClick")
        logoutButton.image = UIImage(named: "icon pencil")
        navigationController?.navigationItem.rightBarButtonItems = [logoutButton, editProfileButton]
    }
    
    func onLogoutClick() {
        presenter.onLogoutClick()
    }
    
    func onEditClick() {
        presenter.onEditClick()
    }
    
    func showEditProfile() {
        Router.showEditProfile(self)
    }
    
}