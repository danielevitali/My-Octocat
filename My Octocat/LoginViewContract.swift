//
//  AuthenticationViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LoginViewContract {
    
    func showLoading(message: String?)
    
    func hideLoading()
    
    func showError(message: String)
    
    func showTwoFactorAuthentication(username: String, password: String)
    
}