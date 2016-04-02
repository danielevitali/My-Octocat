//
//  CommitCell.swift
//  My Octocat
//
//  Created by Daniele Vitali on 4/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class CommitCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    
    func showCommit(commit: Commit) {
        lblMessage.text = commit.message
        lblAuthorName.text = commit.authorName
    }
    
}