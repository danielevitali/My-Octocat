//
//  TwoFactorAuthenticationViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol TwoFactorsAuthenticationViewContract: class {
    
    func showError(message: String)
    
    func showLoading(message: String)
    
    func hideLoading()
    
}