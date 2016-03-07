//
//  2FactorAuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift
import SwiftEventBus

class TwoFactorsAuthenticationPresenter: TwoFactorsAuthenticationPresenterContract {
    
    weak var view: TwoFactorsAuthenticationViewContract!
    var repository: UserRepositoryContract!
    
    let username: String
    let password: String
    let disposeBag: DisposeBag
    
    init(view: TwoFactorsAuthenticationViewContract, repository: UserRepositoryContract, username: String, password: String) {
        self.view = view
        self.repository = repository
        self.username = username
        self.password = password
        disposeBag = DisposeBag()
    }
    
    func viewDidLoad() {
        view.hideLoading()
    }
    
    func onLoginClick(twoFactorAuthenticationCode: String) {
        
        guard !twoFactorAuthenticationCode.isEmpty else {
            view.showError("Type your 2 factors authentication code first")
            return
        }
        
        view.showLoading("Login...")
        repository.twoFactorsLogin(username, password: password, code: twoFactorAuthenticationCode)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
                self.view.hideLoading()
                SwiftEventBus.post(Events.USER_LOGGED_IN)
                }, onError: { errorType in
                    self.view.hideLoading()
                    let error = errorType as! Error
                    self.view.showError(error.message)
                }, onCompleted: {() in
                        
                }, onDisposed: {() in
                        
                }).addDisposableTo(disposeBag)
    }
    
}