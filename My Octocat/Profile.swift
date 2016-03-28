//
//  Profile.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class Profile {
    
    var id: Int
    var name: String
    var username: String
    var location: String?
    var company: String?
    var bio: String?
    var creationDate: NSDate
    var avatarUrl: String?
    var avatar: NSData?
    
    init(json: [String : AnyObject]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.username = json["login"] as! String
        self.location = json["location"] as? String
        self.company = json["company"] as? String
        self.bio = json["bio"] as? String
        self.creationDate = NSDate.dateFromISOString(json["created_at"] as! String)
        self.avatarUrl = json["avatar_url"] as? String
    }
    
    init(entry: ProfileEntry) {
        self.id = entry.id as Int
        self.name = entry.name
        self.username = entry.username
        self.location = entry.location
        self.company = entry.company
        self.bio = entry.bio
        self.creationDate = entry.creationDate
        self.avatarUrl = entry.avatarUrl
    }
}