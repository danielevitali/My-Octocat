//
//  RepositoryViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/29/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol RepositoryViewContract: class {
    
    func showRepositoryTitle(title: String)
    
    func toggleLoading(visible: Bool)
    
    func toggleNoCommitFound(visible: Bool)
    
    func toggleCommitList(visible: Bool)
    
    func reloadCommits()
    
    func showError(message: String)
    
    func showCommit(url: String)
    
    func showRepositoryOnWeb(url: String)
    
}