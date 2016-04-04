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
    
    func refreshUserRepositories()
    
    func toggleLoading(visible: Bool)
    
    func toggleRepositoriesLoading(visible: Bool)
    
    func toggleRepositoriesTable(visible: Bool)
    
    func showEditProfile()
    
    func showRepository(repository: Repository)
    
    func showError(message: String)
    
}