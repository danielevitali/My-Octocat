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
    
    private let instance = RepositoriesRepository()
    
    func getInstance() -> RepositoriesRepository {
        return instance
    }
    
    func search(query: String) -> Observable<Repository> {
        return Observable.create { observer in
            NetworkHelper.getInstance().searchRespository(query, callbackHandler: { (response, error) -> Void in
                if let response = response {
                    for repoResponse in response.items {
                        let repository = Repository(response: repoResponse)
                        observer.on(.Next(repository))
                        observer.on(.Completed)
                    }
                } else {
                    
                }
            })
            return NopDisposable.instance
        }
    }
    
}