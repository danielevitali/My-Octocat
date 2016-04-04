//
//  RepositoryPresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol RepositoryPresenterContract {
    
    var repo: Repository {get set}
    
    func viewDidLoad()
    
    func onCommitClick(indexPath: NSIndexPath)
    
    func onShowRepositoryOnWebClick()
    
}