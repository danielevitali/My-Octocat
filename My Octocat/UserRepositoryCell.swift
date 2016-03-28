//
//  UserRepositoryCell.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/13/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class UserRepositoryCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblOpenIssuesCount: UILabel!
    @IBOutlet weak var lblStarsCount: UILabel!
    @IBOutlet weak var lblForksCount: UILabel!
    
    func showRepository(repository: Repository) {
        lblName.text = repository.name
        lblDescription.text = repository.summary
        lblOpenIssuesCount.text = "\(repository.openIssuesCount)"
        lblStarsCount.text = "\(repository.starsCount)"
        lblForksCount.text = "\(repository.forksCount)"
    }
    
}