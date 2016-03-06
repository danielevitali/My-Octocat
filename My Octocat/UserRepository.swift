//
//  UserRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class UserRepository: UserRepositoryContract {
    
    private static let instance = UserRepository()
    
    class func sharedInstance() -> UserRepository {
        return instance
    }
    
    private init(){
    }
    
    func isUserLoggedIn() -> Bool {
        return false
    }
    
    func login(username: String, password: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            
            let networkTask = GitHubGateway.sharedInstance().loginUser(username, password: password, callbackHandler: { response, twoFacAuthNeeded, error in
                if let response = response {
                    observer.onNext(response)
                    observer.onCompleted()
                } else if let twoFacAuthNeeded = twoFacAuthNeeded where twoFacAuthNeeded {
                    observer.onError(Error(message: error!.message, twoFactAuthNeeded: true))
                } else {
                    observer.onError(Error(message: error!.message, twoFactAuthNeeded: nil))
                }
            })
            
            return AnonymousDisposable {
                networkTask.cancel()
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
    func twoFactorsLogin(username: String, password: String, code: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            let networkTask = GitHubGateway.sharedInstance().loginUser(username, password: password, code: code, callbackHandler: { response, twoFacAuthNeeded, error in
                if let response = response {
                    observer.onNext(response)
                    observer.onCompleted()
                } else {
                    observer.onError(Error(message: error!.message, twoFactAuthNeeded: nil))
                }
            })
        
            return AnonymousDisposable {
                networkTask.cancel()
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }

}