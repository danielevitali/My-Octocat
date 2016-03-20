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

class ProfileNavigatorPresenter: BasePresenter, ProfileNavigatorPresenterContract {
    
    private weak var view: ProfileNavigatorViewContract!
    
    init(view: ProfileNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        if let user = UserRepository.sharedInstance().user {
            view.showProfile(user)
        } else {
            view.showLogin()
        }
    }
    
    func viewDidAppear() {
        SwiftEventBus.onMainThread(self, name: Events.USER_LOGGED_IN) { result in
            self.view.showProfile(UserRepository.sharedInstance().user!)
        }
    }
    
    func viewWillDisappear() {
        SwiftEventBus.unregister(self)
    }
    
    func onLogoutClick() {
        UserRepository.sharedInstance().logout()
        view.showLogin()
    }
    
    func onEditClick() {
        view.showEditProfile()
    }
    
}