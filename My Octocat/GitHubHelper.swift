//
//  NetworkHelper.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class GitHubHelper {
    
    private static let BASE_URL = "https://api.github.com"
    
    private static let SEARCH_REPOSITORIES_PATH = "/search/repositories"
    
    private static let ACCEPT_HEADER = "application/vnd.github.v3+json"
    private static let USER_AGENT_HEADER = "danielevitali.My-Octocat"
    
    private static let instance = GitHubHelper()
    
    static func getInstance() -> GitHubHelper {
        return instance
    }
    
    private init() {
    }
    
    func searchRespository(query: String, callbackHandler callback: (response: RepositoriesResponse?, error: ErrorResponse?) -> Void) {
        let queryParams = ["q" : query]
        let url = buildUrl(GitHubHelper.SEARCH_REPOSITORIES_PATH, params: queryParams)
        sendGetRequest(url, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                if self.isSuccessResponse(response.statusCode) {
                    let response = RepositoriesResponse(json: json)
                    callback(response: response, error: nil)
                } else {
                    let errorResponse = ErrorResponse(json: json)
                    callback(response: nil, error: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(response: nil, error: errorResponse)
            }
        })
    }
    
    private func sendGetRequest(url: NSURL, callbackHandler callback: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            callback(data: data, response: response as? NSHTTPURLResponse, error: error)
        }).resume()
    }
    
    private func addHeadersToRequest(request: NSMutableURLRequest) {
        request.addValue(GitHubHelper.ACCEPT_HEADER, forHTTPHeaderField: "Accept")
        request.addValue(GitHubHelper.USER_AGENT_HEADER, forHTTPHeaderField: "User-Agent")
    }
    
    private func buildUrl(path: String, params: [String:String]) -> NSURL {
        return NSURL(string: (GitHubHelper.BASE_URL + path + escapedParameters(params)))!
    }
    
    private func escapedParameters(parameters: [String:String]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (urlVars.isEmpty ? "" : "?") + urlVars.joinWithSeparator("&")
    }
    
    private func extractJson(data: NSData) -> NSDictionary {
        return try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
    }
    
    private func isSuccessResponse(statusCode: Int) -> Bool {
        return statusCode/100 == 2
    }
    
}