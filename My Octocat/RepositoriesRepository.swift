//
//  RepositoriesRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class RepositoriesRepository {
    
    private static let instance = RepositoriesRepository()
    
    static func sharedInstance() -> RepositoriesRepository {
        return instance
    }
    
    func search(query: String, offset: Int) -> Observable<Page<Repository>> {
        return Observable.create({ observer in
            let accessToken = UserRepository.sharedInstance().user?.accessToken
            let networkTask = GitHubGateway.sharedInstance().searchRespository(query, withOffset: offset, accessToken: accessToken, callbackHandler: { response, error in
                if let response = response {
                    let page = Page<Repository>(items: response.items, totalCount: response.totalCount)
                    observer.onNext(page)
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            })
            return AnonymousDisposable {
                print("Disposed")
                networkTask.cancel()
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
    //TODO: retreive repositories of the user given the username
    func getRepositories(username: String) -> Observable<[Repository]> {
        return Observable.create({ (observer) -> Disposable in
            
            
            
            return AnonymousDisposable {
                
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
}