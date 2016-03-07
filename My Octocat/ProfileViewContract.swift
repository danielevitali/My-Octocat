//
//  ProfileViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol ProfileViewContract: class {
    
    func showUser(user: User)
    
    func showLoading()
    
    func hideLoading()
    
    func showError(message: String)
    
}