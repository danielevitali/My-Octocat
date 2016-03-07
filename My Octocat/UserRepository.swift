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
    
    private var user: User?
    
    private init(){
    }
    
    func getLoggedInUser() -> User? {
        return user
    }
    
    func isUserLoggedIn() -> Bool {
        return user != nil
    }
    
    func getUserRepositories() -> Observable<[Repository]> {
        guard let user = user else {
            return Observable.empty()
        }
        
        return Observable.create({ (observer) -> Disposable in
            
            let networkTask = GitHubGateway.sharedInstance().getRepositories(user.username, callbackHandler: { response, error in
                if let response = response {
                    self.user?.repositories = response
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
    
    func login(username: String, password: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            
            let networkTask = GitHubGateway.sharedInstance().loginUser(username, password: password, callbackHandler: { response, twoFacAuthNeeded, error in
                if let response = response {
                    self.user = response
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
                    self.user = response
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