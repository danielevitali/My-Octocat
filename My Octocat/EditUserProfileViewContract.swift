//
//  EditUserProfileViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol EditUserProfileViewContract: class {
    
    func showUserProfile(profile: Profile)
    
    func toggleMainLoading(visible: Bool)
    
    func toggleAvatarLoading(visible: Bool)
    
    func toggleAvatar(visible: Bool)
    
    func enableToolbar(enable: Bool)
    
    func showAvatar(avatar: NSData?)
    
    func dismiss()
    
    func showError(message: String)
    
}