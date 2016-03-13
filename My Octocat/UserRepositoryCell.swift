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
    
    func showRepository(repository: Repository) {
        lblName.text = repository.name
    }
    
}