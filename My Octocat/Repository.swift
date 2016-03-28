//
//  Repository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class Repository {
    
    var id: Int
    var name: String
    var ownerName: String
    var summary: String?
    var language: String?
    var openIssuesCount: Int
    var starsCount: Int
    var forksCount: Int
    var user: User?
    
    init(json: [String:AnyObject]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.ownerName = (json["owner"] as! [String:AnyObject])["login"] as! String
        self.summary = json["description"] as? String
        self.starsCount = json["stargazers_count"] as! Int
        self.language = json["language"] as? String
        self.forksCount = json["forks_count"] as! Int
        self.openIssuesCount = json["open_issues_count"] as! Int
    }
    
    init(entry: RepositoryEntry) {
        self.id = entry.id as Int
        self.name = entry.name
        self.ownerName = entry.ownerName
        self.summary = entry.summary
        self.starsCount = entry.starsCount as Int
        self.language = entry.language
        self.forksCount = entry.forksCount as Int
        self.openIssuesCount = entry.openIssuesCount as Int
    }
    
}