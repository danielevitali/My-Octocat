//
//  HomePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import SwiftEventBus

class HomePresenter: HomePresenterContract {
    
    private weak var view: HomeViewContract!
    
    init(view: HomeViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        if UserRepository.sharedInstance().user != nil {
            view.showProfileTabHideLoginTab()
        } else {
            view.showLoginTabHideProfileTab()
        }
    }
    
    func viewDidAppear() {
        SwiftEventBus.onMainThread(self, name: Events.USER_LOGGED_IN) { result in
            self.view.showProfileTabHideLoginTab()
        }
        
        SwiftEventBus.onMainThread(self, name: Events.USER_LOGGED_OUT) { result in
            self.view.showLoginTabHideProfileTab()
        }
    }
    
    func viewWillDisappear() {
        SwiftEventBus.unregister(self)
    }
    
}