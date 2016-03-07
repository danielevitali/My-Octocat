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
    let name: String
    let username: String
    let location: String?
    let company: String?
    let bio: String?
    //let creationDate: NSDate
    let avatarUrl: String?
    var repositories: [Repository]?
    
    init(json: [String:AnyObject]) {
        id = json["id"] as! Int
        name = json["name"] as! String
        username = json["login"] as! String
        location = json["location"] as? String
        company = json["company"] as? String
        bio = json["bio"] as? String
        //creationDate = NSDate.dateFromISOString(json["created_at"] as! String)
        avatarUrl = json["avatar_url"] as? String
    }
    
}