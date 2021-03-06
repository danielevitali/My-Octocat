//
//  LoginRepositoryContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/12/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginRepositoryContract {
    
    func getAuthURL() -> NSURL
    
    func loginUserWithWebCode(code: String) -> Observable<User>
    
}