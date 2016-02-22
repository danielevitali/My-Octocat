//
//  ViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewContract, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var cvRepositories: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var lblIntro: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: SearchPresenterContract!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        cvRepositories.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    func toggleLoading(visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func toggleIntroMessage(visible: Bool) {
        lblIntro.hidden = !visible
    }
    
    func toggleNoRepositoryFound(visible: Bool) {
        lblNoResult.hidden = !visible
    }
    
    func refreshRepositoryList() {
        cvRepositories.reloadData()
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.repositories!.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("repositoryCell", forIndexPath: indexPath) as! RepositoryCell
        cell.showRepository(presenter.repositories![indexPath.row])
        return cell
    }


}

