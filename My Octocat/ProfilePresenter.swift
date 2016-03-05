//
//  ProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterContract {
    
    let view: ProfileViewContract
    
    init(view: ProfileViewContract) {
        self.view = view
    }
    
}