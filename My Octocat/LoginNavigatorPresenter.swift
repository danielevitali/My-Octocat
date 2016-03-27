//
//  LoginNavigatorPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class LoginNavigatorPresenter: BasePresenter, LoginNavigatorPresenterContract {
    
    private weak var view: LoginNavigatorViewContract!
    
    init(view: LoginNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.view.showLogin()
    }
    
}