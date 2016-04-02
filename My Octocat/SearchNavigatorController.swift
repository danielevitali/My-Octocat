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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func showSearch() {
        Router.showSearchInNavigatorController(self)
    }
    
    func showRepository(repository: Repository) {
        Router.showRepository(self, repository: repository)
    }
    
}