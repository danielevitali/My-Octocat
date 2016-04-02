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
    
    init(cdUser: CDUser) {
        self.accessToken = cdUser.accessToken
        self.profile = Profile(cdProfile: cdUser.profile)
        self.repositories = [Repository]()
        let cdRepositories = cdUser.repositories.allObjects as! [CDRepository]
        for cdRepository in cdRepositories {
            self.repositories?.append(Repository(cdRepository: cdRepository))
        }
    }
}