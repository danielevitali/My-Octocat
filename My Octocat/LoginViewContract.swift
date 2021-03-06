//
//  AuthenticationViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol LoginViewContract: class {
    
    func loadUrl(url: NSURL)
    
    func showError(message: String)
    
    func toggleLoading(visible: Bool)
    
    func toggleWebView(visible: Bool)
    
}