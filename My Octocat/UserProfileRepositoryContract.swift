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
    
    func getUserProfile() -> Observable<Profile>
    
    func getUserRepositories() -> Observable<[Repository]>
    
    func getUserAvatar() -> Observable<NSData>
    
    func saveUserProfile(name: String, location: String?, company: String?, bio: String?) -> Observable<Profile>
    
    func saveUserAvatar(avatar: NSData?)  -> Observable<Profile>
    
}