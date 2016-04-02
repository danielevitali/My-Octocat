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
    
    func getCommits(repository: Repository) -> Observable<[Commit]> {
        return Observable.create({ (observer) -> Disposable in
            let accessToken = UserRepository.sharedInstance().user?.accessToken
            let networkTask = GitHubGateway.sharedInstance().fetchCommits(repository.ownerName, repositoryName: repository.name, accessToken: accessToken, callbackHandler: { response, error in
                if let response = response {
                    observer.onNext(response)
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            })
            return AnonymousDisposable {
                networkTask.cancel()
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
}