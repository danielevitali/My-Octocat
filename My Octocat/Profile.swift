//
//  Profile.swift
//  My Octocat
//
//  Created by Daniele Vitali on 09/03/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import CoreData

class Profile: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var location: String?
    @NSManaged var company: String?
    @NSManaged var bio: String?
    @NSManaged var creationDate: NSDate
    @NSManaged var avatarUrl: String?
    var avatar: NSData?
    
    init(json: [String:AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Profile", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        id = json["id"] as! Int
        name = json["name"] as! String
        username = json["login"] as! String
        location = json["location"] as? String
        company = json["company"] as? String
        bio = json["bio"] as? String
        creationDate = NSDate.dateFromISOString(json["created_at"] as! String)
        avatarUrl = json["avatar_url"] as? String
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
}