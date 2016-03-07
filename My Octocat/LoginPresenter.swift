//
//  AuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter: LoginPresenterContract {
    
    weak var view: LoginViewContract!
    var repository: UserRepositoryContract!
    
    let disposeBag: DisposeBag
    
    init(view: LoginViewContract, repository: UserRepositoryContract) {
        self.view = view
        self.repository = repository
        self.disposeBag = DisposeBag()
    }
    
    func viewDidLoad() {
        view.hideLoading()
    }
    
    func onLoginClick(username: String, password: String) {
        if checkLoginCredentials(username, password: password) {
            view.showLoading("Login...")
            repository.login(username, password: password)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { user in
                        self.view.hideLoading()
                    }, onError: { errorType in
                        self.view.hideLoading()
                        let error = errorType as! Error
                        if error.twoFactAuthNeeded ?? false {
                            self.view.showTwoFactorAuthentication(username, password: password)
                        } else {
                            self.view.showError(error.message)
                        }
                    }, onCompleted: {() in
                    
                    }, onDisposed: {() in
                    
                }).addDisposableTo(disposeBag)
        }
    }
    
    private func checkLoginCredentials(username: String?, password: String?) -> Bool{
        guard let username = username where !username.isEmpty else {
            view.showError("Type your username first")
            return false
        }
        
        guard let password = password where !password.isEmpty else {
            view.showError("Type your password first")
            return false
        }
        
        return true
    }    
}