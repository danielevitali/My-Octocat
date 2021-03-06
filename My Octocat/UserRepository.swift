//
//  UserRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class UserRepository: LoginRepositoryContract, UserProfileRepositoryContract {
    
    private static let instance = UserRepository()
    
    class func sharedInstance() -> UserRepository {
        return instance
    }
    
    var user: User?
    
    private init(){
        let user = CoreDataGateway.sharedInstance().fetchUser()
        self.user = user
    }
    
    func isUserLoggedIn() -> Bool {
        return user != nil
    }
    
    func getAuthURL() -> NSURL {
        return GitHubGateway.sharedInstance().getWebAuthURL()
    }
    
    func loginUserWithWebCode(code: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            let task = GitHubGateway.sharedInstance().loginUserWithWebCode(code, callbackHandler: { (user, error) -> Void in
                if let user = user {
                    self.user = user
                    CoreDataGateway.sharedInstance().saveAccessToken(user.accessToken)
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
                let task = GitHubGateway.sharedInstance().getUserProfile(self.user!.accessToken, callbackHandler: { (profile, error) -> Void in
                    if let profile = profile {
                        self.user!.profile = profile
                        CoreDataGateway.sharedInstance().saveProfile(profile)
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
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                let task = GitHubGateway.sharedInstance().getUserRepositories(self.user!.accessToken, callbackHandler: { (repositories, error) -> Void in
                    if let repositories = repositories {
                        self.user!.repositories = repositories
                        CoreDataGateway.sharedInstance().saveRepositories(repositories)
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
        } else if let avatar = FilesystemGateway.sharedInstance().getUserAvatar() {
            observable = Observable.create({ (observer) -> Disposable in
                observer.onNext(avatar)
                return AnonymousDisposable{
                }
            })
        } else {
            observable = Observable.create({ (observer) -> Disposable in
                if let image = FilesystemGateway.sharedInstance().getUserAvatar() {
                    observer.onNext(image)
                    return AnonymousDisposable{
                    }
                } else {
                    let avatarUrl = NSURL(string: self.user!.profile!.avatarUrl!)!
                    let task = GitHubGateway.sharedInstance().downloadUserAvatar(avatarUrl, callbackHandler: { (image, error) in
                        if let image = image {
                            FilesystemGateway.sharedInstance().saveUserAvatar(image)
                            observer.onNext(image)
                            observer.onCompleted()
                        } else {
                            observer.onError(error!)
                        }
                    })
                    return AnonymousDisposable {
                        task.cancel()
                    }
                }
            })
        }
        return observable.subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
    func logout() {
        CoreDataGateway.sharedInstance().clearData()
        user = nil
    }
    
    func saveUserProfile(name: String, location: String?, company: String?, bio: String?) -> Observable<Profile> {
        return Observable.create { (observer) -> Disposable in
            let task = GitHubGateway.sharedInstance().editUserProfile(name, location: location, company: company, bio: bio, accessToken: self.user!.accessToken, callbackHandler: { (profile, error) in
                if let profile = profile {
                    self.user?.profile = profile
                    CoreDataGateway.sharedInstance().saveProfile(profile)
                    observer.onNext(profile)
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            })
            return AnonymousDisposable {
                task.cancel()
            }
        }.subscribeOn(ComputationalScheduler.sharedInstance())
    }

}