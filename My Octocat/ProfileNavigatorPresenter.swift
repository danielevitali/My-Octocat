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
    
    private var currentRepository: Repository!
    
    init(view: UserProfileNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.view.showUserProfile()
    }
    
    func viewDidAppear() {
        SwiftEventBus.onMainThread(self, name: Events.SHOW_REPOSITORY) { result in
            self.currentRepository = result.object as! Repository
            self.view.showRepository(self.currentRepository)
        }
    }
    
    func viewWillDisappear() {
        SwiftEventBus.unregister(self)
    }
    
    func onLogoutClick() {
        UserRepository.sharedInstance().logout()
        SwiftEventBus.post(Events.USER_LOGGED_OUT)
    }
    
    func onEditClick() {
        view.showEditProfile(UserRepository.sharedInstance().user!)
    }
    
    func onShowRepositoryOnWebClick() {
        view.showRepositoryOnWeb(currentRepository.url)
    }
    
}