//
//  TwoFactorsAuthenticationRepositoryContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

protocol TwoFactorsAuthenticationRepositoryContract {
    
    func twoFactorsLogin(username: String, password: String, code: String) -> Observable<User> 
    
}