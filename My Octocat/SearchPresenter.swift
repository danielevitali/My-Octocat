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
    let disposeBag: DisposeBag
    
    init(view: SearchViewContract) {
        self.view = view
        self.disposeBag = DisposeBag()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func onQueryTextChanged(query: String) {
        self.view.startLoadingRepositories()
        RepositoriesRepository.sharedInstance().search(query, offset: 0)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { page in
                    self.view.addRepositoryToList(page.item)
                }, onError: { errorType in
                    let error = errorType as! Error
                    self.view.showError(error.message)
                }, onCompleted: {() in
                    self.view.didFinishLoadingRepositories()
                }, onDisposed: {() in
                    
                }).addDisposableTo(disposeBag)
        
    }
    
    func onRepositoryClick(repository: Repository) {
        view.showRepositoryDetails(repository)
    }
    
}