//
//  AuthenticationViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginViewContract {
    
    @IBOutlet weak var webView: UIWebView!
    
    var presenter: LoginPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}