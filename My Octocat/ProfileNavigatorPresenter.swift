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
    
}