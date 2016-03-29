//
//  ProfileNavigatorViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol UserProfileNavigatorViewContract: class {
    
    func showRepository(repository: Repository)
    
    func showUserProfile()
    
    func showEditProfile(user: User)
    
}