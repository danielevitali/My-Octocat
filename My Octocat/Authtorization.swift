//
//  Authtorization.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class Authorization {
    
    var accessToken: String
    var scope: String
    var tokenType: String
    
    init(json: [String:AnyObject]) {
        self.accessToken = json["access_token"] as! String
        self.scope = json["scope"] as! String
        self.tokenType = json["token_type"] as! String
    }
    
    init(entry: AuthorizationEntry) {
        self.accessToken = entry.accessToken
        self.scope = entry.scope
        self.tokenType = entry.tokenType
    }
    
}