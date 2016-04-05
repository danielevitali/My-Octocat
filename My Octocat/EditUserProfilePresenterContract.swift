//
//  EditUserProfilePresenterContract.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol EditUserProfilePresenterContract {
    
    func viewDidLoad()
    
    func onSaveClick()
    
    func onEndEditingName(name: String)
    
    func onEndEditingLocation(location: String)
    
    func onEndEditingCompany(company: String)
    
    func onEndEditingBio(bio: String)
    
}