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
    private let user: User
    private let repository: UserProfileRepositoryContract
    
    private var avatar: NSData?
    private var name: String!
    private var location: String?
    private var company: String?
    private var bio: String?
    
    init(view: EditUserProfileViewContract, repository: UserProfileRepositoryContract, user: User) {
        self.view = view
        self.user = user
        self.repository = repository
    }
    
    func viewDidLoad() {
        if let profile = user.profile {
            view.toggleMainLoading(false)
            view.enableToolbar(true)
            showUserProfile(profile)
            checkAvatar(profile)
        } else {
            view.toggleMainLoading(true)
            view.enableToolbar(false)
            repository.getUserProfile()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] profile in
                    self.view.toggleMainLoading(false)
                    self.view.enableToolbar(true)
                    self.showUserProfile(profile)
                    self.checkAvatar(profile)
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
        avatar = profile.avatar
        name = profile.name
        location = profile.location
        company = profile.company
        bio = profile.bio
        view.showUserProfile(profile)
    }
    
    private func checkAvatar(profile: Profile) {
        guard profile.avatarUrl != nil else {
            return
        }
        
        if profile.avatar == nil {
            view.toggleAvatarLoading(true)
            view.toggleAvatar(false)
            repository.getUserAvatar()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [unowned self] avatar in
                    self.avatar = avatar
                    self.view.toggleAvatarLoading(false)
                    self.view.toggleAvatar(true)
                    self.view.showAvatar(avatar)
                    }, onError: { [unowned self] errorType in
                        let error = errorType as! Error
                        self.view.toggleAvatarLoading(false)
                        self.view.toggleAvatar(true)
                        self.view.showError(error.message)
                    }, onCompleted: { () in
                        
                    }, onDisposed: { () in
                        
                }).addDisposableTo(disposeBag)

        }
    }
    
    func onSaveClick() {
        guard name != "" else {
            view.showError("Type your name")
            return
        }
        
        view.toggleMainLoading(true)
        var observable = repository.saveUserProfile(name, location: location, company: company, bio: bio)
        if user.profile!.avatar != avatar {
            observable = observable.concat(repository.saveUserAvatar(avatar))
        }
        observable.observeOn(MainScheduler.instance)
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
    
    func onCancelClick() {
        view.dismiss()
    }
    
    func onAvatarClick() {
        view.showAvatarActions()
    }
    
    func onSelectAvatarClick() {
        view.showImageSelector()
    }
    
    func onDeleteAvatarClick() {
        avatar = nil
        view.showAvatar(nil)
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
    
    func onNewAvatarSelect(image: NSData) {
        avatar = image
        view.showAvatar(image)
    }
    
    func onNewAvatarSelectionCancel() {
        
    }
    
}