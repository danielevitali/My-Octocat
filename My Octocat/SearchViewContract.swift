//
//  SearchViewContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol SearchViewContract {
    
    func toggleLoading(visible: Bool)
    
    func toggleIntroMessage(visible: Bool)
    
    func toggleNoRepositoryFound(visible: Bool)
    
    func addRepositoryToList(repository: Repository)
    
    func showError(message: String)
    
    func showRepositoryDetails(repository: Repository)
    
    func startLoadingRepositories()
    
    func didFinishLoadingRepositories()
    
}