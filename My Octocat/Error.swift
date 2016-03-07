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
    let twoFactAuthNeeded: Bool?
    
}