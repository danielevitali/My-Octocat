//
//  ProfileNavigatorPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import SwiftEventBus

class ProfileNavigatorPresenter: BasePresenter, ProfileNavigatorPresenterContract {
    
    weak var view: ProfileNavigatorViewContract!
    
    init(view: ProfileNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidAppear() {
        SwiftEventBus.onMainThread(self, name: Events.USER_LOGGED_IN) { result in
            self.view.showProfile(result.object as! User)
        }
    }
    
    func viewWillDisappear() {
        SwiftEventBus.unregister(self)
    }
    
}