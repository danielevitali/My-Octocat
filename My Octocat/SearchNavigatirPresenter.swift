//
//  SearchNavigatirPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class SearchNavigatorPresenter: BasePresenter, SearchNavigatorPresenterContract {
    
    private weak var view: SearchNavigatorViewContract!
    
    init(view: SearchNavigatorViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.view.showSearch()
    }    
    
}