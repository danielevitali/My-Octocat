//
//  SearchPresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol SearchPresenterContract {
    
    var repositories: [Repository]? {get set}
    
    var view: SearchViewContract {get}
    
    func viewWillAppear()
    
    func viewDidDisappear()
    
    func onQueryTextChanged(query: String)
    
    func onRepositoryClick(repository: Repository)
    
}