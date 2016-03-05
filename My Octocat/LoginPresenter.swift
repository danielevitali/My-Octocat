//
//  AuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterContract {
    
    let view: LoginViewContract
    
    init(view: LoginViewContract) {
        self.view = view
    }
    
}