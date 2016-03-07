//
//  AuthenticationPresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LoginPresenterContract {
    
    func viewDidLoad()
    
    func onLoginClick(username: String, password: String)
    
}