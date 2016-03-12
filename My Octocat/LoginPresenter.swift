//
//  AuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift
import SwiftEventBus

class LoginPresenter: BasePresenter, LoginPresenterContract {
    
    private static let AUTH_URL = "https://github.com/login/oauth/authorize?client_id=" + CLIENT_ID + "&redirect_uri=" + CALLBACK_URL + "&scopes=user,repo" 
    private static let CLIENT_ID = "2bcfc4da0df7619b2364"
    private static let CLIENT_SECRET = "7ffe329bafeb9d19d12d909887b68d5165612f32"
    private static let CALLBACK_URL = "my-octocat://callback"
    
    weak var view: LoginViewContract!
    var repository: LoginRepositoryContract
    
    init(view: LoginViewContract, repository: LoginRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        view.loadUrl(repository.getAuthURL())
    }
    
    func onLoadNewRequest(request: NSURLRequest) -> Bool {
        let url = request.URL!
        if url.absoluteString.containsString(LoginPresenter.CALLBACK_URL) {
            let code = url.valueForKey("code") as! String
            repository.loginUserWithWebCode(code)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { user in
                    SwiftEventBus.post(Events.USER_LOGGED_IN)//, sender: user)
                    }, onError: { errorType in
                        let error = errorType as! Error
                        self.view.showError(error.message)
                    }, onCompleted: { () in
                        
                    }, onDisposed: { () in
                        
                }).addDisposableTo(disposeBag)
            return false
        }
        return true
    }
    
}