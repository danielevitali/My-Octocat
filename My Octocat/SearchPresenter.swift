//
//  SearchPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenter: SearchPresenterContract {
    
    let view: SearchViewContract
    var repositories: [Repository]?
    
    init(view: SearchViewContract) {
        self.view = view
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func onQueryTextChanged(query: String) {
        return RepositoriesRepository.getInstance().search(query)
                .observeOn(MainScheduler.instance)
                .subscribeNext({ (abc) -> Void in
                    
                })
    }
    
    func onRepositoryClick(repository: Repository) {
        view.showRepositoryDetails(repository)
    }
    
}