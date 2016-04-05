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
    
    func isUserLoggedIn() -> Bool
    
    func getAuthURL() -> NSURL
    
    func loginUserWithWebCode(code: String) -> Observable<User>
    
    func getUserProfile() -> Observable<Profile>
    
    func getUserRepositories() -> Observable<[Repository]>
    
    func getUserAvatar() -> Observable<NSData>
    
    func logout()
    
    func saveUserProfile(name: String, location: String?, company: String?, bio: String?) -> Observable<Profile>
    
}