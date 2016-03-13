//
//  FilesystemGateway.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/13/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class FilesystemGateway {
    
    private static let USER_AVATAR_FILENAME = "avatar.jpg"
    
    private static let instance = FilesystemGateway()
    
    static func sharedInstance() -> FilesystemGateway {
        return instance
    }
    
    private init() {
    }
    
    func saveUserAvatar(image: NSData) {
        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let path = url.URLByAppendingPathComponent(FilesystemGateway.USER_AVATAR_FILENAME).path!
        image.writeToFile(path, atomically: true)
    }
    
    func deleteUserAvatar() {
        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let path = url.URLByAppendingPathComponent(FilesystemGateway.USER_AVATAR_FILENAME).path!
        do {
            try NSFileManager.defaultManager().removeItemAtPath(path)
        } catch {}
    }
    
    func getUserAvatar() -> NSData? {
        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        if let path = url.URLByAppendingPathComponent(FilesystemGateway.USER_AVATAR_FILENAME).path {
            return NSFileManager.defaultManager().contentsAtPath(path)
        }
        return nil
    }
    
}