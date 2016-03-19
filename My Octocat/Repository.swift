//
//  Repository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class Repository: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var ownerName: String
    @NSManaged var summary: String?
    @NSManaged var language: String?
    @NSManaged var openIssuesCount: Int
    @NSManaged var starsCount: Int
    @NSManaged var forksCount: Int
    
    init(json: [String:AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Repository", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        id = json["id"] as! Int
        name = json["name"] as! String
        ownerName = (json["owner"] as! [String:AnyObject])["login"] as! String
        summary = json["description"] as? String
        starsCount = json["stargazers_count"] as! Int
        language = json["language"] as? String
        forksCount = json["forks_count"] as! Int
        openIssuesCount = json["open_issues_count"] as! Int
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}