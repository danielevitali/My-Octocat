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
    
    private static let CALLBACK_URL = "my-octocat://callback"
    
    weak var view: LoginViewContract!
    var repository: LoginRepositoryContract
    var loggingUser: Bool!
    
    init(view: LoginViewContract, repository: LoginRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
        view.loadUrl(repository.getAuthURL())
        view.toggleLoading(true)
        view.toggleWebView(false)
        loggingUser = false
    }
    
    func onFinishLoadingWebPage() {
        view.toggleLoading(false)
        view.toggleWebView(true)
    }
    
    func onErrorLoadingWebPage(error: NSError) {
        if !loggingUser {
            view.toggleLoading(false)
            view.showError(error.localizedDescription)
        }
    }
    
    func onLoadNewRequest(request: NSURLRequest) -> Bool {
        let url = request.URL!
        if url.absoluteString.containsString(LoginPresenter.CALLBACK_URL) {
            view.toggleLoading(true)
            view.toggleWebView(false)
            let code = url.query!.substringFromIndex((url.query!.rangeOfString("=")?.endIndex)!)
            repository.loginUserWithWebCode(code)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { user in
                    SwiftEventBus.post(Events.USER_LOGGED_IN, sender: user)
                    }, onError: { errorType in
                        let error = errorType as! Error
                        self.view.showError(error.message)
                    }, onCompleted: { () in
                        
                    }, onDisposed: { () in
                        
                }).addDisposableTo(disposeBag)
            loggingUser = true
            return false
        }
        return true
    }
    
}