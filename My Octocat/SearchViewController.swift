//
//  ViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewContract {

    @IBOutlet weak var cvRepositories: UICollectionView!
    
    var presenter: SearchPresenterContract!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
    }
    
    func toggleLoading(visible: Bool) {
        
    }
    
    func toggleIntoMessage(visible: Bool) {
        
    }
    
    func toggleNoRepositoryFound(visible: Bool) {
        
    }
    
    func showRepositories(repositories: [Repository]) {
        
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }


}

