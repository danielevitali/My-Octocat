//
//  RepositoryCell.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class RepositoryCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStarsCount: UILabel!
    @IBOutlet weak var lblForksCount: UILabel!
    @IBOutlet weak var lblIssuesCount: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    func showRepository(repository: Repository) {
        lblName.text = repository.name
        lblAuthor.text = repository.ownerName
        lblDescription.text = repository.description
        lblStarsCount.text = String(repository.starsCount)
        lblForksCount.text = String(repository.forksCount)
        lblIssuesCount.text = String(repository.openIssuesCount)
        lblLanguage.text = repository.language
        
    }
}