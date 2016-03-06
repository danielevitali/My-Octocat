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
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var vLoading: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    
    var presenter: LoginPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onLoginClick(sender: AnyObject) {
        presenter.onLoginClick(tfUsername.text!, password: tfPassword.text!)
    }
    
    func showLoading(message: String?) {
        lblLoading.text = message
        aiLoading.startAnimating()
        vLoading.hidden = false
    }
    
    func hideLoading() {
        aiLoading.stopAnimating()
        vLoading.hidden = true
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showTwoFactorAuthentication(username: String, password: String) {
        Router.showTwoFactorAuthentication(self, username: username, password: password)
    }
    
    deinit {
        presenter.viewDeinit()
        presenter = nil
    }
    
}