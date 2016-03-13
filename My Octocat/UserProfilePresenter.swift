//
//  ProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class UserProfilePresenter: BasePresenter, UserProfilePresenterContract {
    
    weak var view: UserProfileViewContract!
    let repository: UserProfileRepositoryContract
    
    var user: User
    
    init(view: UserProfileViewContract, repository: UserProfileRepositoryContract, user: User) {
        self.view = view
        self.user = user
        self.repository = repository
    }
    
    func viewDidLoad() {
        if let profile = user.profile {
            view.showUserProfile(profile)
        } else {
            view.showLoading()
            
        }
    }
}