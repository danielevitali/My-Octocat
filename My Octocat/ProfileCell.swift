//
//  ProfileCell.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/13/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    func showProfile(profile: Profile) {
        lblName.text = profile.name
        lblUsername.text = profile.username
    }
    
    func showAvatar(image: NSData) {
        imgAvatar.image = UIImage(data: image)
    }
    
}