//
//  Commit.swift
//  My Octocat
//
//  Created by Daniele Vitali on 4/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class Commit {
    
    var message: String
    var authorName: String
    var url: String
    
    init(json: [String : AnyObject]) {
        let commitJson = json["commit"] as! [String : AnyObject]
        self.message = commitJson["message"] as! String
        self.authorName = (commitJson["author"] as! [String : AnyObject])["name"] as! String
        self.url = json["html_url"] as! String
    }
    
}