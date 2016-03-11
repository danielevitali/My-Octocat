//
//  ErrorResponse.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class ErrorResponse {
    
    let message: String
    let errors: [ErrorInfoResponse]
 
    init(json: [String : AnyObject]) {
        message = json["message"] as! String
        var errors = [ErrorInfoResponse]()
        if let array = json["errors"] as? NSArray {
            for element in array {
                errors.append(ErrorInfoResponse(json: element as! [String:AnyObject]))
            }
        }
        self.errors = errors
    }
    
    init(error: NSError) {
        message = error.localizedDescription
        errors = [ErrorInfoResponse]()
    }
    
}