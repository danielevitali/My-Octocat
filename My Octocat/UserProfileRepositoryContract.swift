//
//  UserProfileRepositoryContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/13/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

protocol UserProfileRepositoryContract {
    
    var user: User? {get set}
    
    func getUserProfile() -> Observable<User>
    
    func getUserRepositories() -> Observable<User>
    
    func getUserAvatar() -> Observable<NSData>
    
}