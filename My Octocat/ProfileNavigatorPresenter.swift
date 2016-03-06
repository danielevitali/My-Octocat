//
//  ProfileNavigatorPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import SwiftEventBus

class ProfileNavigatorPresenter: ProfileNavigatorPresenterContract {
    
    var view: ProfileNavigatorViewContract!
    var repository: UserRepositoryContract!
    
    init(view: ProfileNavigatorViewContract, repository: UserRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidAppear() {
        SwiftEventBus.onMainThread(self, name: Events.USER_LOGGED_IN) { result in
            self.view.showProfile()
        }
    }
    
    func viewWillDisappear() {
        SwiftEventBus.unregister(self)
    }
    
    func viewDeinit() {
        view = nil
        repository = nil
    }
    
}