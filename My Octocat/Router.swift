//
//  Router.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/21/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class Router {
    
    static func showHome(window: UIWindow, userLoggedIn: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! UINavigationController
        let homeTabBarController = homeViewController.visibleViewController as! UITabBarController
        let searchViewController = homeTabBarController.viewControllers!.first! as! SearchViewController
        searchViewController.presenter = SearchPresenter(view: searchViewController)
        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
    }
    
}
