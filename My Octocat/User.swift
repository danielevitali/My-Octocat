//
//  User.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var authorization: Authorization
    @NSManaged var profile: Profile?
    @NSManaged var repositories: [Repository]?
    
    init(authorization: Authorization, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.id = 0
        self.authorization = authorization
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}