//
//  ProfileCell.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/13/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class UserProfileCell: UITableViewCell {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblMemberSince: UILabel!
    @IBOutlet weak var vCity: UIView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var vCompany: UIView!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var vBio: UIView!
    @IBOutlet weak var lblBio: UILabel!
    
    func showProfile(profile: Profile) {
        lblName.text = profile.name
        lblUsername.text = profile.username
        lblMemberSince.text = "Member since \(NSDate.ISOStringFromDate(profile.creationDate))"
        if let location = profile.location {
            lblCity.text = location
            vCity.hidden = false
        } else {
            vCity.hidden = true
        }
        if let company = profile.company {
            lblCompany.text = company
            vCompany.hidden = false
        } else {
            vCompany.hidden = true
        }
        if let bio = profile.bio {
            lblBio.text = bio
            vBio.hidden = false
        } else {
            vBio.hidden = true
        }
    }
    
    func showAvatar(image: NSData) {
        imgAvatar.image = UIImage(data: image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    
}