//
//  ProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class UserProfilePresenter: BasePresenter, UserProfilePresenterContract {
    
    weak var view: UserProfileViewContract!
    let repository: UserProfileRepositoryContract
    
    var user: User
    
    init(view: UserProfileViewContract, repository: UserProfileRepositoryContract, user: User) {
        self.view = view
        self.user = user
        self.repository = repository
    }
    
    func viewDidLoad() {
        if let profile = user.profile {
            view.toggleLoading(false)
            view.showUserProfile(profile)
        } else {
            view.toggleLoading(true)
            repository.getUserProfile()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] profile in
                    self.view.toggleLoading(false)
                    self.view.showUserProfile(profile)
                    self.showRepositories()
                    self.showAvatar()
                    }, onError: { [unowned self] errorType in
                        let error = errorType as! Error
                        self.view.toggleLoading(false)
                        self.view.showError(error.message)
                    }, onCompleted: { () -> Void in
                
                    }, onDisposed: { () -> Void in
                
                }).addDisposableTo(disposeBag)
        }
    }
    
    private func showRepositories() {
        repository.getUserRepositories()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] repositories in
                self.view.toggleLoading(false)
                self.view.showUserRepositories(repositories)
                }, onError: { [unowned self] errorType in
                    let error = errorType as! Error
                    self.view.toggleLoading(false)
                    self.view.showError(error.message)
                }, onCompleted: { () -> Void in
                    
                }, onDisposed: { () -> Void in
                    
            }).addDisposableTo(disposeBag)
    }
    
    private func showAvatar() {
        repository.getUserAvatar()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] image in
                self.view.showUserAvatar(image)
                }, onError: { errorType in
                    
                }, onCompleted: { () in
                    
                }, onDisposed: { () in
                    
            }).addDisposableTo(disposeBag)
    }
}