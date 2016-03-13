//
//  Profile.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Profile {
    
    var id: Int
    var name: String
    var username: String
    var location: String?
    var company: String?
    var bio: String?
    var creationDate: NSDate
    var avatarUrl: NSURL?
    
    init(json: [String:AnyObject]) {
        id = json["id"] as! Int
        name = json["name"] as! String
        username = json["login"] as! String
        location = json["location"] as? String
        company = json["company"] as? String
        bio = json["bio"] as? String
        creationDate = NSDate.dateFromISOString(json["created_at"] as! String)
        if let url = json["avatar_url"] as? String {
            avatarUrl = NSURL(string: url)
        }
    }
    
}