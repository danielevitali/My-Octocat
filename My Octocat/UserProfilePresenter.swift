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
    
    private weak var view: UserProfileViewContract!
    private let repository: UserProfileRepositoryContract
    
    var userProfile: Profile? {
        return repository.user!.profile
    }
    var userRepositories: [Repository]? {
        return repository.user!.repositories
    }
    
    init(view: UserProfileViewContract, repository: UserProfileRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        if let profile = userProfile {
            view.toggleLoading(false)
            view.showUserProfile(profile)
            view.toggleRepositoriesLoading(false)
            view.toggleRepositoriesTable(true)
            view.refreshUserRepositories()
        } else {
            view.toggleLoading(true)
            repository.getUserProfile()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] profile in
                    self.view.toggleLoading(false)
                    self.view.showUserProfile(profile)
                    self.loadRepositories()
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
    
    private func loadRepositories() {
        view.toggleRepositoriesLoading(true)
        view.toggleRepositoriesTable(false)
        repository.getUserRepositories()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] repositories in
                self.view.toggleRepositoriesLoading(false)
                self.view.toggleRepositoriesTable(true)
                self.view.refreshUserRepositories()
                }, onError: { [unowned self] errorType in
                    let error = errorType as! Error
                    self.view.toggleRepositoriesLoading(false)
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