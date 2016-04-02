//
//  RepositoriesTable.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/28/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class CDRepository: NSManagedObject {
    
    private static let ENTRY_NAME = "Repository"
    
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var ownerName: String
    @NSManaged var summary: String?
    @NSManaged var language: String?
    @NSManaged var openIssuesCount: NSNumber
    @NSManaged var starsCount: NSNumber
    @NSManaged var forksCount: NSNumber
    @NSManaged var url: String
    @NSManaged var user: CDUser
    
    init(repository: Repository, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName(CDRepository.ENTRY_NAME, inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.id = repository.id
        self.name = repository.name
        self.ownerName = repository.ownerName
        self.summary = repository.summary
        self.starsCount = repository.starsCount
        self.language = repository.language
        self.forksCount = repository.forksCount
        self.openIssuesCount = repository.openIssuesCount
        self.url = repository.url
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}