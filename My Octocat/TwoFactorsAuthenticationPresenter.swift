//
//  2FactorAuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class TwoFactorsAuthenticationPresenter: TwoFactorsAuthenticationPresenterContract {
    
    var view: TwoFactorsAuthenticationViewContract!
    var repository: TwoFactorsAuthenticationRepositoryContract!
    
    let username: String
    let password: String
    let disposeBag: DisposeBag
    
    init(view: TwoFactorsAuthenticationViewContract, repository: TwoFactorsAuthenticationRepositoryContract, username: String, password: String) {
        self.view = view
        self.repository = repository
        self.username = username
        self.password = password
        disposeBag = DisposeBag()
    }
    
    func viewDidLoad() {
        
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
                }, onError: { errorType in
                    self.view.hideLoading()
                    let error = errorType as! Error
                    self.view.showError(error.message)
                }, onCompleted: {() in
                        
                }, onDisposed: {() in
                        
                }).addDisposableTo(disposeBag)
    }
    
    func viewDeinit() {
        view = nil
        repository = nil
    }
    
}