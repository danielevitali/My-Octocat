//
//  ProfileNavigatorPresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol UserProfileNavigatorPresenterContract {
    
    func viewDidLoad()
    
    func viewDidAppear()
    
    func viewWillDisappear()
    
    func onLogoutClick()
    
    func onEditClick()
    
}