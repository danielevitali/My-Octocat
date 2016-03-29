//
//  SearchNavigatorViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol SearchNavigatorViewContract: class {
    
    func showSearch()
    
    func showRepository(repository: Repository)
    
}