//
//  Authtorization.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Authorization {
    
    let accessToken: String
    let scope: [String]
    let tokenType: String
    
    init(json: [String:AnyObject]) {
        self.accessToken = json["access_token"] as! String
        self.scope = (json["scope"] as! String).characters.split(",").map(String.init)
        self.tokenType = json["token_type"] as! String
    }
    
}