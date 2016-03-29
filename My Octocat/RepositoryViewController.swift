//
//  RepositoryViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class RepositoryViewController: UIViewController, RepositoryViewContract {
    
    var presenter: RepositoryPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}