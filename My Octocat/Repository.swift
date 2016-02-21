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
    var description: String
    var language: String
    var forkCount: Int
    var openIssuesCount: Int
    
    init(response: RepositoryResponse) {
        id = response.id
        name = response.name
        ownerName = response.owner.login
        description = response.description
        language = response.language
        forkCount = response.forkCount
        openIssuesCount = response.openIssuesCount        
    }
    
}