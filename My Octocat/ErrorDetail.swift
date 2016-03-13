//
//  ErrorDetail.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/12/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct ErrorDetail {
    
    let resource: String
    let field: String
    let code: String
    
    init(json: [String:AnyObject]) {
        self.resource = json["resource"] as! String
        self.field = json["field"] as! String
        self.code = json["code"] as! String
    }
    
}