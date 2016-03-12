//
//  Error.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Error: ErrorType {
    
    let message: String
    let errors: [ErrorInfoResponse]
    
    init(json: [String : AnyObject]) {
        self.message = json["message"] as! String
        var errors = [ErrorInfoResponse]()
        if let array = json["errors"] as? NSArray {
            for element in array {
                errors.append(ErrorInfoResponse(json: element as! [String : AnyObject]))
            }
        }
        self.errors = errors
    }
    
    init(message: String) {
        self.message = message
        self.errors = [ErrorInfoResponse]()
    }
    
    init(error: NSError) {
        self.message = error.localizedDescription
        self.errors = [ErrorInfoResponse]()
    }
    
}