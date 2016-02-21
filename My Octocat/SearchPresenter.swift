//
//  SearchPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterContract {
    
    let view: SearchViewContract
    
    init(view: SearchViewContract) {
        self.view = view
    }
    
}