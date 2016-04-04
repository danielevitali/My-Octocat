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
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    var presenter: LoginPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        webView.delegate = self
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    func loadUrl(url: NSURL) {
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        presenter.onFinishLoadingWebPage()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return presenter.onLoadNewRequest(request)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        presenter.onErrorLoadingWebPage(error!)
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func toggleLoading(visible: Bool) {
        if visible {
            aiLoading.startAnimating()
        } else {
            aiLoading.stopAnimating()
        }
    }
    
    func toggleWebView(visible: Bool) {
        webView.hidden = !visible
    }
}