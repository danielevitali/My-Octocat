//
//  ProfileViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol UserProfileViewContract: class {
    
    func showUserProfile(profile: Profile)
    
    func showUserAvatar(image: NSData)
    
    func showUserRepositories(repositories: [Repository])
    
    func toggleLoading(visible: Bool)
    
    func showError(message: String)
    
}