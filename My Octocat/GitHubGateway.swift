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
    private static let ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token"
    private static let WEB_AUTH_URL = "https://github.com/login/oauth/authorize"
    
    private static let SEARCH_REPOSITORIES_PATH = "/search/repositories"
    private static let USER_PROFILE_PATH = "/user"
    private static let USER_REPOSITORIES_PATH = "/user/repos"
    
    private static let CLIENT_ID = "2bcfc4da0df7619b2364"
    private static let CLIENT_SECRET = "7ffe329bafeb9d19d12d909887b68d5165612f32"
    private static let CALLBACK_URL = "my-octocat://callback"
    
    private static let ACCEPT_HEADER = "application/vnd.github.v3+json"
    private static let USER_AGENT_HEADER = "danielevitali.My-Octocat"
    
    private static let REPOSITORIES_PER_PAGE_COUNT = 50
    
    private static let instance = GitHubGateway()
    
    static func sharedInstance() -> GitHubGateway {
        return instance
    }
    
    private init() {
    }
    
    func getWebAuthURL() -> NSURL {
        let queryParams = ["client_id" : GitHubGateway.CLIENT_ID, "scope" : "user,repo"]
        let urlString = "\(GitHubGateway.WEB_AUTH_URL)\(escapedParameters(queryParams))"
        return NSURL(string: urlString)!
    }

    func loginUserWithWebCode(code: String, callbackHandler callback: (authorization: Authorization?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let queryParams = ["client_id" : GitHubGateway.CLIENT_ID, "client_secret" : GitHubGateway.CLIENT_SECRET, "code" : code]
        let request = NSMutableURLRequest(URL: NSURL(string: "\(GitHubGateway.ACCESS_TOKEN_URL)\(escapedParameters(queryParams))")!)
        addHeadersToRequest(request, accessToken: nil)
        return sendPostRequest(request, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                if self.isSuccessResponse(response.statusCode) {
                    let authorization = Authorization(json: json)
                    CoreDataGateway.sharedInstance().saveAuthorization(authorization)
                    callback(authorization: authorization, error: nil)
                } else {
                    callback(authorization: nil, error: Error(json: json))
                }
            } else {
                callback(authorization: nil, error: Error(error: error!))
            }
        })
    }
    
    func getUserProfile(accessToken: String, callbackHandler callback: (profile: Profile?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.USER_PROFILE_PATH, params: nil))
        addHeadersToRequest(request, accessToken: accessToken)
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                if self.isSuccessResponse(response.statusCode) {
                    let profile = Profile(json: json)
                    CoreDataGateway.sharedInstance().saveProfile(profile)
                    callback(profile: profile, error: nil)
                } else {
                    callback(profile: nil, error: Error(json: json))
                }
            } else {
                callback(profile: nil, error: Error(error: error!))
            }
        })
    }
    
    func getUserRepositories(accessToken: String, callbackHandler callback: (repositories: [Repository]?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.USER_REPOSITORIES_PATH, params: nil))
        addHeadersToRequest(request, accessToken: accessToken)
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                if self.isSuccessResponse(response.statusCode) {
                    var repositories = [Repository]()
                    for repo in json["items"] as! [[String : AnyObject]] {
                        let repository = Repository(json: repo)
                        repositories.append(repository)
                    }
                    callback(repositories: repositories, error: nil)
                } else {
                    callback(repositories: nil, error: Error(json: json))
                }
            } else {
                callback(repositories: nil, error: Error(error: error!))
            }
        })
    }
    
    func searchRespository(query: String, withOffset offset: Int, accessToken: String?, callbackHandler callback: (response: RepositoriesResponse?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let page = offset / GitHubGateway.REPOSITORIES_PER_PAGE_COUNT
        let queryParams = ["q" : query, "page" : "\(page)", "per_page" : "\(GitHubGateway.REPOSITORIES_PER_PAGE_COUNT)"]
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.SEARCH_REPOSITORIES_PATH, params: queryParams))
        addHeadersToRequest(request, accessToken: accessToken)
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
            if let response = response, let data = data {
                let json = self.extractJson(data)
                if self.isSuccessResponse(response.statusCode) {
                    callback(response: RepositoriesResponse(json: json), error: nil)
                } else {
                    callback(response: nil, error: Error(json: json))
                }
            } else {
                callback(response: nil, error: Error(error: error!))
            }
        })
    }
    
    func getRepositories(username: String, callbackHandler callback: (response: [Repository]?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: buildUrl(GitHubGateway.USER_REPOSITORIES_PATH, params: nil))
        
        return sendGetRequest(request, callbackHandler: { (data, response, error) in
            
        })
    }

    private func sendGetRequest(request: NSMutableURLRequest, callbackHandler callback: (data: NSData?, response: NSHTTPURLResponse?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            callback(data: data, response: response as? NSHTTPURLResponse, error: error)
        })
        task.resume()
        return task
    }
    
    private func sendPostRequest(request: NSMutableURLRequest, callbackHandler callback: (data: NSData?, response: NSHTTPURLResponse?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        request.HTTPMethod = "POST"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            callback(data: data, response: response as? NSHTTPURLResponse, error: error)
        })
        task.resume()
        return task
    }
    
    func downloadUserAvatar(url: NSURL, callbackHandler callback: (image: NSData?, error: Error?) -> Void) -> NSURLSessionDataTask {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
            if let error = error {
                callback(image: nil, error: Error(error: error))
            } else {
                callback(image: data, error: nil)
            }
        })
        task.resume()
        return task
    }
    
    private func addHeadersToRequest(request: NSMutableURLRequest, accessToken: String?) {
        request.addValue(GitHubGateway.ACCEPT_HEADER, forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(GitHubGateway.USER_AGENT_HEADER, forHTTPHeaderField: "User-Agent")
        if let accessToken = accessToken {
            request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
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
            let escapedValue = "\(value)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            urlVars += [key + "=" + "\(escapedValue)"]
        }
        return (urlVars.isEmpty ? "" : "?") + urlVars.joinWithSeparator("&")
    }
    
    private func extractJson(data: NSData) -> [String:AnyObject] {
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        if let array = json as? [AnyObject] {
            return ["items": array]
        }
        return json as! [String : AnyObject]
    }
    
    private func isSuccessResponse(statusCode: Int) -> Bool {
        return statusCode/100 == 2
    }
    
}