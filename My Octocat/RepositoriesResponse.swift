//
//  RepositoriesResponse.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class RepositoriesResponse {
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    init(json: [String:AnyObject]) {
        totalCount = json["total_count"] as! Int
        incompleteResults = json["incomplete_results"] as! Bool
        var items = [Repository]()
        if let array = json["items"] as? [AnyObject] {
            for element in array {
                items.append(Repository(json: element as! [String:AnyObject]))
            }
        }
        self.items = items
    }
    
}