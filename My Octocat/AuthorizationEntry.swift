//
//  AuthorizationEntry.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/28/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class AuthorizationEntry: NSManagedObject {
    
    private static let ENTRY_NAME = "Authorization"
    
    @NSManaged var accessToken: String
    @NSManaged var scope: String
    @NSManaged var tokenType: String
    @NSManaged var user: UserEntry
    
    init(authorization: Authorization, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName(AuthorizationEntry.ENTRY_NAME, inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.accessToken = authorization.accessToken
        self.scope = authorization.scope
        self.tokenType = authorization.tokenType
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}