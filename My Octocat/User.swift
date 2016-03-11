//
//  User.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct User {
    
    var profile: Profile?
    var authorization: Authorization
    var repositories: [Repository]?
    
    init(authorization: Authorization) {
        self.authorization = authorization
    }
    
}