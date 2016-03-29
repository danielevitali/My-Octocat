//
//  UserEntity.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/28/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class CDUser: NSManagedObject {
    
    private static let ENTRY_NAME = "User"
    
    @NSManaged var accessToken: String
    @NSManaged var profile: CDProfile
    @NSManaged var repositories: [CDRepository]
    
    init(accessToken: String, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName(CDUser.ENTRY_NAME, inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.accessToken = accessToken
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}