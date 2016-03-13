//
//  UserRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class UserRepository: LoginRepositoryContract, UserProfileRepositoryContract {
    
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
    
    func getUserProfile() -> Observable<User> {
        let observable: Observable<User>
        if user == nil {
            observable = Observable.error(Error(message: "User is not logged in"))
        } else if user!.profile != nil {
            observable = Observable.just(user!)
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                let task = GitHubGateway.sharedInstance().getUserProfile(self.user!.authorization.accessToken, callbackHandler: { (profile, error) -> Void in
                    if let profile = profile {
                        self.user!.profile = profile
                        observer.onNext(self.user!)
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
    
    func getUserRepositories() -> Observable<User> {
        let observable: Observable<User>
        if user == nil {
            observable = Observable.error(Error(message: "User is not logged in"))
        } else if user!.repositories != nil {
            observable = Observable.just(user!)
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                let task = GitHubGateway.sharedInstance().getUserRepositories(self.user!.authorization.accessToken, callbackHandler: { (repositories, error) -> Void in
                    if let repositories = repositories {
                        self.user!.repositories = repositories
                        observer.onNext(self.user!)
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