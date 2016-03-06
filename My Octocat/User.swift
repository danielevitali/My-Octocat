//
//  User.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct User {
    
    let id: Int
    
    init(json: [String:AnyObject]) {
        id = json["id"] as! Int
    }
    
}