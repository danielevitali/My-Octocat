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
    let items: [RepositoryResponse]
    
    init(json: NSDictionary) {
        totalCount = json["total_count"] as! Int
        incompleteResults = json["incomplete_results"] as! Bool
        var items = [RepositoryResponse]()
        if let array = json["items"] as? NSArray {
            for element in array {
                items.append(RepositoryResponse(json: element as! NSDictionary))
            }
        }
        self.items = items
    }
    
}