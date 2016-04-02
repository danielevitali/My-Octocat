//
//  RepositoryPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryPresenter: BasePresenter, RepositoryPresenterContract {
    
    private weak var view: RepositoryViewContract!
    
    var repo: Repository
    
    private let repository = RepositoriesRepository.sharedInstance()
    
    init(view: RepositoryViewContract, repo: Repository) {
        self.view = view
        self.repo = repo
    }
    
    func viewDidLoad() {
        view.showRepositoryTitle(repo.name)
        view.toggleLoading(true)
        view.toggleCommitList(false)
        view.toggleNoCommitFound(false)
        repository.getCommits(repo)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] commits in
                self.view.toggleLoading(false)
                self.repo.commits = commits
                if commits.isEmpty {
                    self.view.toggleNoCommitFound(true)
                } else {
                    self.view.toggleCommitList(true)
                    self.view.reloadCommits()
                }
                }, onError: { [unowned self] errorType in
                    let error = errorType as! Error
                    self.view.toggleLoading(false)
                    self.view.showError(error.message)
                }, onCompleted: { () -> Void in
                    
                }, onDisposed: { () -> Void in
                    
            }).addDisposableTo(disposeBag)
    }
    
    func onCommitClick(indexPath: NSIndexPath) {
        view.showCommit(repo.commits![indexPath.row].url)
    }
}