//
//  RepositoryResponse.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class RepositoryResponse {
    
    let id: Int
    let name: String
    let fullName: String
    let owner: UserResponse
    let privateFlag: Bool
    let htmlUrl: NSURL
    let description: String
    let fork: Bool
    let url: NSURL
    let createdAt: NSDate
    let updatedAt: NSDate
    let pushedAt: NSDate
    let homepage: NSURL
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String
    let forkCount: Int
    let openIssuesCount: Int
    let masterBranch: String
    let defaultBranch: String
    let score: Float
    
    init(json: NSDictionary) {
        id = json["id"] as! Int
        name = json["name"] as! String
        fullName = json["full_name"] as! String
        owner = UserResponse(json: json["owner"] as! NSDictionary)
        privateFlag = json["private"] as! Bool
        htmlUrl = NSURL(string: json["html_url"] as! String)!
        description = json["description"] as! String
        fork = json["fork"] as! Bool
        url = NSURL(string: json["url"] as! String)!
        createdAt = NSDate.dateFromISOString(json["created_at"] as! String)
        updatedAt = NSDate.dateFromISOString(json["updated_at"] as! String)
        pushedAt = NSDate.dateFromISOString(json["pushed_at"] as! String)
        homepage = NSURL(string: json["homepage"] as! String)!
        size = json["size"] as! Int
        stargazersCount = json["stargazers_count"] as! Int
        watchersCount = json["watchers_count"] as! Int
        language = json["language"] as! String
        forkCount = json["fork_count"] as! Int
        openIssuesCount = json["open_issues_count"] as! Int
        masterBranch = json["master_branch"] as! String
        defaultBranch = json["default_branch"] as! String
        score = json["score"] as! Float
    }
    
}
