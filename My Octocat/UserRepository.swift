//
//  UserRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class UserRepository: LoginRepositoryContract {
    
    private static let instance = UserRepository()
    
    class func sharedInstance() -> UserRepository {
        return instance
    }
    
    var user: User?
    
    private init(){
    }
    
    func isUserLoggedIn() -> Bool {
        return user != nil
    }
    
    func getAuthURL() -> NSURL {
        return GitHubGateway.sharedInstance().getWebAuthURL()
    }
    
    func loginUserWithWebCode(code: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            let task = GitHubGateway.sharedInstance().loginUserWithWebCode(code, callbackHandler: { (authorization, error) -> Void in
                if let authorization = authorization {
                    self.user = User(authorization: authorization)
                    observer.onNext(self.user!)
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            })
            return AnonymousDisposable{
                task.cancel()
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
    func getUserProfile() -> Observable<Profile> {
        let observable: Observable<Profile>
        if user == nil {
            observable = Observable.error(Error(message: "User is not logged in"))
        } else if let profile = user!.profile {
            observable = Observable.just(profile)
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                let task = GitHubGateway.sharedInstance().getUserProfile(self.user!.authorization.accessToken, callbackHandler: { (profile, error) -> Void in
                    if let profile = profile {
                        self.user!.profile = profile
                        observer.onNext(profile)
                        observer.onCompleted()
                    } else {
                        observer.onError(error!)
                    }
                })
                return AnonymousDisposable{
                    task.cancel()
                }
            })
        }
        return observable.subscribeOn(ComputationalScheduler.sharedInstance())
    }

}