//
//  Repository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Repository {
    
    var id: Int
    var name: String
    var ownerName: String
    var description: String?
    var language: String?
    var openIssuesCount: Int
    var starsCount: Int
    var forksCount: Int
    
    init(json: [String:AnyObject]) {
        id = json["id"] as! Int
        name = json["name"] as! String
        ownerName = (json["owner"] as! [String:AnyObject])["login"] as! String
        description = json["description"] as? String
        starsCount = json["stargazers_count"] as! Int
        language = json["language"] as? String
        forksCount = json["forks_count"] as! Int
        openIssuesCount = json["open_issues_count"] as! Int
    }
    
}