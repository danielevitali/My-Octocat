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