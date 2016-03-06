//
//  TwoFactorAuthenticationViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class TwoFactorsAuthenticationViewController: UIViewController, TwoFactorsAuthenticationViewContract {
    
    @IBOutlet weak var vLoading: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var tfAuthenticationCode: UITextField!
    
    var presenter: TwoFactorsAuthenticationPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onLoginClick(sender: AnyObject) {
        presenter.onLoginClick(tfAuthenticationCode.text!)
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showLoading(message: String) {
        aiLoading.startAnimating()
        lblLoading.text = message
        vLoading.hidden = false
    }
    
    func hideLoading() {
        vLoading.hidden = true
        aiLoading.stopAnimating()
    }
    
    deinit {
        presenter.viewDeinit()
        presenter = nil
    }
    
}