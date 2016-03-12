//
//  UserRepository.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class ProfileRepository {
    
    private static let instance = ProfileRepository()
    
    class func sharedInstance() -> ProfileRepository {
        return instance
    }
    
    private init(){
    }
    
    //TODO: retreive the profile of a given user
    private func getProfile() -> Observable<Profile> {
        return Observable.create({ (observer) -> Disposable in
            
            
            return AnonymousDisposable {
                
            }
        }).subscribeOn(ComputationalScheduler.sharedInstance())
    }
    
}