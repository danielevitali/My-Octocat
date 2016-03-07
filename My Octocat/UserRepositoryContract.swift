//
//  UserRepositoryContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryContract: class {
    
    func login(username: String, password: String) -> Observable<User>
    
    func twoFactorsLogin(username: String, password: String, code: String) -> Observable<User>
    
    func isUserLoggedIn() -> Bool
    
    func getLoggedInUser() -> User?
    
    func getUserRepositories() -> Observable<[Repository]>
    
}