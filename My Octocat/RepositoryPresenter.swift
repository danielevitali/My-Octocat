//
//  RepositoryPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryPresenter: BasePresenter, RepositoryPresenterContract {
    
    private weak var view: RepositoryViewContract!
    
    private let repository: Repository
    
    init(view: RepositoryViewContract, repository: Repository) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        
    }
}