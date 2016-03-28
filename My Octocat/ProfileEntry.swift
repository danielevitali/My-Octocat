//
//  AuthorizationEntry.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/28/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class ProfileEntry: NSManagedObject {
    
    private static let ENTRY_NAME = "Profile"
    
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var location: String?
    @NSManaged var company: String?
    @NSManaged var bio: String?
    @NSManaged var creationDate: NSDate
    @NSManaged var avatarUrl: String?
    @NSManaged var user: UserEntry
    
    init(profile: Profile, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName(ProfileEntry.ENTRY_NAME, inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.id = profile.id
        self.name = profile.name
        self.username = profile.username
        self.location = profile.location
        self.company = profile.company
        self.bio = profile.bio
        self.creationDate = profile.creationDate
        self.avatarUrl = profile.avatarUrl
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}