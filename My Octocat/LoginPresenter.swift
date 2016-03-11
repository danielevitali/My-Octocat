//
//  AuthenticationPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter: LoginPresenterContract {
    
    weak var view: LoginViewContract!
    var repository: UserRepositoryContract!
    
    init(view: LoginViewContract, repository: UserRepositoryContract) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
    }
    
}