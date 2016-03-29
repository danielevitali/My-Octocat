//
//  SearchPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift
import SwiftEventBus

class SearchPresenter: BasePresenter, SearchPresenterContract {
    
    weak var view: SearchViewContract!
    var repositories: [Repository]?
    
    init(view: SearchViewContract) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.view.toggleRepositoryList(false)
        self.view.toggleNoRepositoryFound(false)
        self.view.toggleIntroMessage(true)
        self.view.toggleLoading(false)
    }
    
    func onQueryTextChanged(query: String) {
        self.view.toggleRepositoryList(false)
        self.view.toggleNoRepositoryFound(false)
        self.view.toggleIntroMessage(false)
        self.view.toggleLoading(true)
        
        RepositoriesRepository.sharedInstance().search(query, offset: 0)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { page in
                self.repositories = page.items
                self.view.toggleLoading(false)
                
                if self.repositories!.isEmpty {
                    self.view.toggleNoRepositoryFound(true)
                } else {
                    self.view.reloadRepositories()
                    self.view.toggleRepositoryList(true)
                }
                }, onError: { errorType in
                    self.view.toggleLoading(false)
                    self.view.toggleIntroMessage(true)
                    
                    let error = errorType as! Error
                    self.view.showError(error.message)
                }, onCompleted: {() in
                    
                }, onDisposed: {() in
                    
                }).addDisposableTo(disposeBag)
        
    }
    
    func onRepositoryClick(indexPath: NSIndexPath) {
        SwiftEventBus.post(Events.SHOW_REPOSITORY, sender: repositories![indexPath.row])
    }
    
}