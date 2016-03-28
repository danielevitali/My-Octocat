//
//  User.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class User {
    
    var accessToken: String
    var profile: Profile?
    var repositories: [Repository]?
    
    init(json: [String : AnyObject]) {
        self.accessToken = json["access_token"] as! String
    }
    
    init(entry: UserEntry) {
        self.accessToken = entry.accessToken
        self.profile = Profile(entry: entry.profile)
        self.repositories = [Repository]()
        for repository in entry.repositories {
            self.repositories?.append(Repository(entry: repository))
        }
    }
}