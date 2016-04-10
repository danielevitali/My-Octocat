//
//  EditUserProfileViewController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class EditUserProfileViewController: UIViewController, EditUserProfileViewContract, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tfCompany: UITextField!
    @IBOutlet weak var tfBio: UITextField!
    @IBOutlet weak var aiLoadingAvatar: UIActivityIndicatorView!
    @IBOutlet weak var vMainLoading: UIView!
    @IBOutlet weak var aiMainLoading: UIActivityIndicatorView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var presenter: EditUserProfilePresenterContract!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func onSaveClick(sender: AnyObject) {
        presenter.onSaveClick()
    }
    
    @IBAction func onEditingName(sender: AnyObject) {
        presenter.onEndEditingName(tfName.text!)
    }
    
    @IBAction func onEditingLocation(sender: AnyObject) {
        presenter.onEndEditingLocation(tfLocation.text!)
    }
    
    @IBAction func onEditingCompany(sender: AnyObject) {
        presenter.onEndEditingCompany(tfCompany.text!)
    }
    
    @IBAction func onEditingBio(sender: AnyObject) {
        presenter.onEndEditingBio(tfBio.text!)
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        presenter.onCancelClick()
    }
    
    func showUserProfile(profile: Profile) {
        showAvatar(profile.avatar)
        tfName.text = profile.name
        tfLocation.text = profile.location
        tfCompany.text = profile.company
        tfBio.text = profile.bio
    }
    
    func toggleMainLoading(visible: Bool) {
        vMainLoading.hidden = !visible
        if visible {
            aiMainLoading.startAnimating()
        } else {
            aiMainLoading.stopAnimating()
        }
    }
    
    func toggleAvatarLoading(visible: Bool) {
        if visible {
            aiLoadingAvatar.startAnimating()
        } else {
            aiLoadingAvatar.stopAnimating()
        }
    }
    
    func toggleAvatar(visible: Bool) {
        imgAvatar.hidden = !visible
    }
    
    func enableToolbar(enable: Bool) {
        for item in toolbar.items! {
            item.enabled = enable
        }
    }
    
    func showAvatar(avatar: NSData?) {
        if let avatar = avatar {
            imgAvatar.image = UIImage(data: avatar)
        } else {
            imgAvatar.image = UIImage(named: "avatar placeholder")
        }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showError(message: String) {
        ErrorAlert(message: message).show(self)
    }
}