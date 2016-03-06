//
//  NetworkHelper.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class GitHubGateway {
    
    private static let BASE_URL = "https://api.github.com"
    
    private static let SEARCH_REPOSITORIES_PATH = "/search/repositories"
    private static let USER_PATH = "/user"
    
    private static let ACCEPT_HEADER = "application/vnd.github.v3+json"
    private static let USER_AGENT_HEADER = "danielevitali.My-Octocat"
    private static let REPOSITORIES_PER_PAGE_COUNT = 50
    
    private static let instance = GitHubGateway()
    
    static func sharedInstance() -> GitHubGateway {
        return instance
    }
    
    private init() {
    }
    
    func searchRespository(query: String, withOffset offset: Int, callbackHandler callback: (response: RepositoriesResponse?, error: ErrorResponse?) -> Void) -> NSURLSessionDataTask {
        let page = offset / GitHubGateway.REPOSITORIES_PER_PAGE_COUNT
        let queryParams = ["q" : query, "page" : "\(page)", "per_page" : "\(GitHubGateway.REPOSITORIES_PER_PAGE_COUNT)"]
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.SEARCH_REPOSITORIES_PATH, params: queryParams))
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
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
    
    func loginUser(username: String, password: String, callbackHandler callback: (response: User?, twoFacAuthNeeded: Bool?, error: ErrorResponse?) -> Void) -> NSURLSessionDataTask {
        return loginUser(username, password: password, code: nil, callbackHandler: callback)
    }

    func loginUser(username: String, password: String, code: String?, callbackHandler callback: (response: User?, twoFacAuthNeeded: Bool?, error: ErrorResponse?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.USER_PATH, params: nil))
        
        let loginString = "\(username):\(password)"
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        if let code = code {
            request.addValue(code, forHTTPHeaderField: "X-GitHub-OTP")
        }
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                print(json)
                if self.isSuccessResponse(response.statusCode) {
                    let response = User(json: json)
                    callback(response: response, twoFacAuthNeeded: false, error: nil)
                } else if let otpHeader = response.allHeaderFields["X-GitHub-OTP"] as? String where otpHeader.containsString("required") {
                    let errorResponse = ErrorResponse(json: json)
                    callback(response: nil, twoFacAuthNeeded: true, error: errorResponse)
                } else {
                    let errorResponse = ErrorResponse(json: json)
                    callback(response: nil, twoFacAuthNeeded: nil, error: errorResponse)
                }
            } else {
                let errorResponse = ErrorResponse(error: error!)
                callback(response: nil, twoFacAuthNeeded: nil, error: errorResponse)
            }
        })
    }

    private func sendGetRequest(request: NSMutableURLRequest, callbackHandler callback: (data:NSData?, response: NSHTTPURLResponse?, error:NSError?) -> Void) -> NSURLSessionDataTask {
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            callback(data: data, response: response as? NSHTTPURLResponse, error: error)
        })
        task.resume()
        return task
    }
    
    private func addHeadersToRequest(request: NSMutableURLRequest) {
        request.addValue(GitHubGateway.ACCEPT_HEADER, forHTTPHeaderField: "Accept")
        request.addValue(GitHubGateway.USER_AGENT_HEADER, forHTTPHeaderField: "User-Agent")
    }
    
    private func buildUrl(path: String, params: [String:String]?) -> NSURL {
        return NSURL(string: (GitHubGateway.BASE_URL + path + escapedParameters(params)))!
    }
    
    private func escapedParameters(parameters: [String:String]?) -> String {
        
        guard let parameters = parameters else {
            return ""
        }
        
        var urlVars = [String]()
        for (key, value) in parameters {
            let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (urlVars.isEmpty ? "" : "?") + urlVars.joinWithSeparator("&")
    }
    
    private func extractJson(data: NSData) -> [String:AnyObject] {
        return try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [String:AnyObject]
    }
    
    private func isSuccessResponse(statusCode: Int) -> Bool {
        return statusCode/100 == 2
    }
    
}