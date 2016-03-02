//
//  File.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class ErrorInfoResponse {
    
    let resource: String
    let field: String
    let code: String
    
    init(json: [String:AnyObject]) {
        resource = json["resource"] as! String
        field = json["field"] as! String
        code = json["code"] as! String
    }
    
}