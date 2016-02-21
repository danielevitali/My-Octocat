//
//  SearchPresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol SearchPresenterContract {
    
    var view: SearchViewContract {get}
    
    func onQueryTextChanged(query: String)
    
    func onRepositoryClick(repository: Repository)
    
}