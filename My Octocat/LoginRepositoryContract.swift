//
//  LoginRepositoryContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/6/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginRepositoryContract {
    
    func login(username: String, password: String) -> Observable<User>
    
}