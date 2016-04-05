//
//  EditUserProfilePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class EditUserProfilePresenter: BasePresenter, EditUserProfilePresenterContract {
    
    private weak var view: EditUserProfileViewContract!
    private let repository: UserProfileRepositoryContract
    
    private var user: User {
        return repository.user!
    }
    
    private var name: String!
    private var location: String?
    private var company: String?
    private var bio: String?
    
    init(view: EditUserProfileViewContract, repository: UserProfileRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        if let profile = user.profile {
            view.toggleMainLoading(false)
            view.enableToolbar(true)
            showUserProfile(profile)
        } else {
            view.toggleMainLoading(true)
            view.enableToolbar(false)
            repository.getUserProfile()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] profile in
                    self.view.toggleMainLoading(false)
                    self.view.enableToolbar(true)
                    self.showUserProfile(profile)
                    }, onError: { [unowned self] errorType in
                        let error = errorType as! Error
                        self.view.toggleMainLoading(false)
                        self.view.enableToolbar(true)
                        self.view.showError(error.message)
                        self.view.dismiss()
                    }, onCompleted: { () in
                        
                    }, onDisposed: { () in
                        
                }).addDisposableTo(disposeBag)
        }
    }
    
    private func showUserProfile(profile: Profile) {
        name = profile.name
        location = profile.location
        company = profile.company
        bio = profile.bio
        view.showUserProfile(profile)
    }
    
    func onSaveClick() {
        guard name != "" else {
            view.showError("Type your name")
            return
        }
        
        view.toggleMainLoading(true)
        repository.saveUserProfile(name, location: location, company: company, bio: bio)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] profile in
                self.view.dismiss()
                }, onError: { [unowned self] errorType in
                    let error = errorType as! Error
                    self.view.toggleMainLoading(false)
                    self.view.showError(error.message)
                }, onCompleted: { () in
                    
                }, onDisposed: { () in

            }).addDisposableTo(disposeBag)
    }
    
    func onEndEditingName(name: String) {
        self.name = name
    }
    
    func onEndEditingLocation(location: String) {
        self.location = location
    }
    
    func onEndEditingCompany(company: String) {
        self.company = company
    }
    
    func onEndEditingBio(bio: String) {
        self.bio = bio
    }
    
}