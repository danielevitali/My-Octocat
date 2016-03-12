//
//  BasePresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/12/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class BasePresenter {
    
    let disposeBag: DisposeBag
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
}