//
//  ViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewContract, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var cvRepositories: UICollectionView!
    @IBOutlet weak var cvRepositoriesFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var lblIntro: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: SearchPresenterContract!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
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
    
    func toggleRepositoryList(visible: Bool) {
        cvRepositories.hidden = !visible
    }
    
    func reloadRepositories() {
        cvRepositories.reloadData()
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
    
    func showRepositoryDetails(respository: Repository) {
        
    }
    
    func addRepositoriesToList(repositories: [Repository]) {
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.repositories?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("repositoryCell", forIndexPath: indexPath) as! RepositoryCell
        cell.showRepository(presenter.repositories![indexPath.row])
        return cell
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.onQueryTextChanged(searchBar.text!)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

