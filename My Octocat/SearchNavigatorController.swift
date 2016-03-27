//
//  SearchNavigatorController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class SearchNavigatorController: UINavigationController, SearchNavigatorViewContract {
    
    var presenter: SearchNavigatorPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func showSearch() {
        Router.showSearchInNavigatorController(self)
    }
    
}