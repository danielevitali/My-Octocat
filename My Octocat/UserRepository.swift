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
                        FilesystemGateway.sharedInstance().deleteUserAvatar()
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
    
    func getUserRepositories() -> Observable<[Repository]> {
        let observable: Observable<[Repository]>
        if user == nil {
            observable = Observable.error(Error(message: "User is not logged in"))
        } else if let repositories = user!.repositories {
            observable = Observable.just(repositories)
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                let task = GitHubGateway.sharedInstance().getUserRepositories(self.user!.authorization.accessToken, callbackHandler: { (repositories, error) -> Void in
                    if let repositories = repositories {
                        self.user!.repositories = repositories
                        observer.onNext(repositories)
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
    
    func getUserAvatar() -> Observable<NSData> {
        let observable: Observable<NSData>
        if user == nil {
            observable = Observable.error(Error(message: "User is not logged in"))
        } else if user!.profile == nil {
            observable = Observable.error(Error(message: "User doesn't have a profile"))
        } else if user!.profile!.avatarUrl == nil {
            observable = Observable.empty()
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                if let image = FilesystemGateway.sharedInstance().getUserAvatar() {
                    observer.onNext(image)
                    return AnonymousDisposable{
                    }
                } else {
                    let task = GitHubGateway.sharedInstance().downloadUserAvatar(self.user!.profile!.avatarUrl!, callbackHandler: { (image, error) in
                        if let image = image {
                            FilesystemGateway.sharedInstance().saveUserAvatar(image)
                            observer.onNext(image)
                            observer.onCompleted()
                        } else {
                            observer.onError(error!)
                        }
                    })
                    return AnonymousDisposable{
                        task.cancel()
                    }
                }
            })
        }
        return observable.subscribeOn(ComputationalScheduler.sharedInstance())
    }

}