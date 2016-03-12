//
//  ProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class ProfilePresenter: BasePresenter, ProfilePresenterContract {
    
    weak var view: ProfileViewContract!
    
    var user: User
    
    init(view: ProfileViewContract, user: User) {
        self.view = view
        self.user = user
    }
    
    //TODO check for profile and repository list
    func viewDidLoad() {
        if let profile = user.profile {
            view.showUserProfile(profile)
        } else {
            view.showLoading()
            
        }
    }
}