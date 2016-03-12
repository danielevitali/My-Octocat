//
//  AuthenticationViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginViewContract, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var presenter: LoginPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        webView.delegate = self
    }
    
    func loadUrl(url: NSURL) {
        print(url)
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return presenter.onLoadNewRequest(request)
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showProfile() {
        
    }
}