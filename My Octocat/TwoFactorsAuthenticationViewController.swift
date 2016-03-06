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
    
    var presenter: TwoFactorsAuthenticationPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showLoading(message: String) {
        
    }
    
    func hideLoading() {
        
    }
    
    deinit {
        presenter.viewDeinit()
        presenter = nil
    }
    
}