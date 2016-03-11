//
//  Error.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Error: ErrorType {
    
    let type: Type
    let message: String?
    let errors: [ErrorInfoResponse]?
    
    init(type: Type, json: [String : AnyObject]) {
        self.type = type
        self.message = json["message"] as? String
        var errors = [ErrorInfoResponse]()
        if let array = json["errors"] as? NSArray {
            for element in array {
                errors.append(ErrorInfoResponse(json: element as! [String : AnyObject]))
            }
        }
        self.errors = errors
    }
    
    init(type: Type, error: NSError) {
        self.type = type
        message = error.localizedDescription
        errors = [ErrorInfoResponse]()
    }
    
    init(type: Type) {
        self.type = type
        self.message = nil
    }
    
    enum Type {
        case TWO_FACT_REQUIRED
        case UNKNOWN
    }
    
}