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
    let errorDetails: [ErrorDetail]
    
    init(json: [String : AnyObject]) {
        self.message = json["message"] as! String
        var errorDetails = [ErrorDetail]()
        if let array = json["errors"] as? NSArray {
            for element in array {
                errorDetails.append(ErrorDetail(json: element as! [String : AnyObject]))
            }
        }
        self.errorDetails = errorDetails
    }
    
    init(message: String) {
        self.message = message
        self.errorDetails = [ErrorDetail]()
    }
    
    init(error: NSError) {
        self.message = error.localizedDescription
        self.errorDetails = [ErrorDetail]()
    }
    
}