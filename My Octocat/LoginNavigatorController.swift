//
//  LoginNavigatorController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LoginNavigatorController: UINavigationController, LoginNavigatorViewContract {
    
    var presenter: LoginNavigatorPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showLogin() {
        Router.showLoginInNavigatorController(self)
    }
    
}