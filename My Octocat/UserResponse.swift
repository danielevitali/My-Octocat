//
//  UserResponse.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class UserResponse {
 
    let id: Int
    let login: String
    let avatarUrl: NSURL
    let garvatarId: String
    let url: NSURL
    let receivedEventsUrl: NSURL
    let type: String
    
    init(json: NSDictionary) {
        id = json["id"] as! Int
        login = json["login"] as! String
        avatarUrl = NSURL(string: json["avatar_url"] as! String)!
        garvatarId = json["gravatar_id"] as! String
        url = NSURL(string: json["url"] as! String)!
        receivedEventsUrl = NSURL(string: json["received_events_url"] as! String)!
        type = json["type"] as! String
    }
}
