//
//  ProfilePresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol UserProfilePresenterContract {
    
    var user: User {get set}
    
    func viewDidLoad()
    
}