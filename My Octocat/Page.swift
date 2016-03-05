//
//  Page.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

struct Page<T> {
    let items: [T]
    let totalCount: Int
}