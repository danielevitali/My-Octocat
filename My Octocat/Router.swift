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
        let homeTabBarController = storyboard.instantiateViewControllerWithIdentifier("HomeTabBarController") as! UITabBarController
        let searchNagivationController = homeTabBarController.viewControllers!.first! as! UINavigationController
        let searchViewController = searchNagivationController.visibleViewController as! SearchViewController
        searchViewController.presenter = SearchPresenter(view: searchViewController)
        window.rootViewController = homeTabBarController
        window.makeKeyAndVisible()
    }
    
    static func showRepositoryDetails(viewController: UIViewController, repository: Repository) {
        
    }
    
}
