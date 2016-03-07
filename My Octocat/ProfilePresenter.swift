//
//  ProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class ProfilePresenter: ProfilePresenterContract {
    
    weak var view: ProfileViewContract!
    var repository: UserRepositoryContract!
    
    var user: User
    let disposeBag: DisposeBag
    
    init(view: ProfileViewContract, repository: UserRepositoryContract, user: User) {
        self.view = view
        self.repository = repository
        self.user = user
        self.disposeBag = DisposeBag()
    }
    
    func viewDidLoad() {
        if user.repositories == nil {
            view.showLoading()
            repository.getUserRepositories()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (repositories) -> Void in
                    self.user.repositories = repositories
                    self.view.hideLoading()
                    self.view.showUser(self.user)
                    }, onError: { (errorType) -> Void in
                        self.view.hideLoading()
                        self.view.showError("Cannnot load your repositories")
                    }, onCompleted: { () -> Void in
                        
                    }, onDisposed: { () in
                }).addDisposableTo(disposeBag)
        } else {
            view.showUser(user)
        }
    }
}