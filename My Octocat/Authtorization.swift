//
//  Authtorization.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class Authorization: NSManagedObject {
    
    @NSManaged var accessToken: String
    @NSManaged var scope: String
    @NSManaged var tokenType: String
    @NSManaged var user: User
    
    init(json: [String:AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Authorization", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.accessToken = json["access_token"] as! String
        self.scope = json["scope"] as! String
        self.tokenType = json["token_type"] as! String
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}