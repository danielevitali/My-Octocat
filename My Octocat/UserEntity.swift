//
//  UserEntity.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/28/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class UserEntry: NSManagedObject {
    
    private static let ENTRY_NAME = "User"
    
    @NSManaged var accessToken: String
    @NSManaged var profile: ProfileEntry
    @NSManaged var repositories: [RepositoryEntry]
    
    init(accessToken: String, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName(UserEntry.ENTRY_NAME, inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.accessToken = accessToken
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}