//
//  User.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class User {
    
    var authorization: Authorization
    var profile: Profile?
    var repositories: [Repository]?
    
    init(authorization: Authorization) {
        self.authorization = authorization
    }
    
    init(entry: UserEntry) {
        self.authorization = Authorization(entry: entry.authorization)
        self.profile = Profile(entry: entry.profile)
        self.repositories = [Repository]()
        for repository in entry.repositories {
            self.repositories?.append(Repository(entry: repository))
        }
    }
}