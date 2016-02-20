//
//  NetworkHelper.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import SwiftEventBus

class NetworkHelper {
    
    private static let BASE_URL = "https://api.github.com"
    
    private static let SEARCH_REPOSITORIES = "/search/repositories"
    
    private static let DATE_PATTERN = "YYYY-MM-DDTHH:MM:SSZ"
    private static let HEADER = "Accept: application/vnd.github.v3+json"
    
    private let instance = NetworkHelper()
    
    func searchRespository(query: String) {
        
    }
    
}