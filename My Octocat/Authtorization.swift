//
//  Authtorization.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Authorization {
    
    let id: Int
    let token: String
    
    init(json: [String:AnyObject]) {
        self.id = json["id"] as! Int
        self.token = json["token"] as! String
    }
    
}