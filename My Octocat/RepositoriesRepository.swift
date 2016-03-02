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
            let networkTask = GitHubGateway.sharedInstance().searchRespository(query, withOffset: offset, callbackHandler: { response, error in
                if let response = response {
                    for repoResponse in response.items {
                        let repository = Repository(response: repoResponse)
                        observer.onNext(Page(item: repository, totalCount: response.totalCount))
                    }
                    observer.onCompleted()
                } else {
                    observer.onError(Error(message: error!.message))
                }
            })
            return AnonymousDisposable {
                print("Disposed")
                networkTask.cancel()
            }
        }).subscribeOn(WorkerScheduler.sharedInstance())
    }
    
}