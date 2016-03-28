//
//  ProfileNavigatorPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import SwiftEventBus
import CoreData

class UserProfileNavigatorPresenter: BasePresenter, UserProfileNavigatorPresenterContract {
    
    private weak var view: UserProfileNavigatorViewContract!
    
    init(view: UserProfileNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.view.showUserProfile()
    }
    
    func onLogoutClick() {
        UserRepository.sharedInstance().logout()
        SwiftEventBus.post(Events.USER_LOGGED_OUT)
    }
    
    func onEditClick() {
        view.showEditProfile(UserRepository.sharedInstance().user!)
    }
    
}