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
    
    private static let HOME_STORYBOARD = "Home"
    private static let HOME_TAB_BAR_CONTROLLER = "HomeTabBarController"
    private static let SEARCH_TAB_POSITION = 0
    private static let PROFILE_TAB_POSITION = 1
    private static let EVENTS_TAB_POSITION = 2
    
    private static let ACCOUNT_STORYBOARD = "Account"
    private static let LOGIN_VIEW_CONTROLLER = "LoginViewController"
    private static let PROFILE_VIEW_CONTROLLER = "ProfileViewController"
    
    private static let EVENTS_STORYBOARD = "Events"
    private static let EVENTS_VIEW_CONTROLLER = "EventsViewController"
    
    static func showHome(window: UIWindow, userLoggedIn: Bool) {
        let homeStoryboard = UIStoryboard(name: Router.HOME_STORYBOARD, bundle: nil)
        let homeTabBarController = homeStoryboard.instantiateViewControllerWithIdentifier(Router.HOME_TAB_BAR_CONTROLLER) as! UITabBarController
        
        let searchNagivationController = homeTabBarController.viewControllers![Router.SEARCH_TAB_POSITION] as! UINavigationController
        let searchViewController = searchNagivationController.visibleViewController as! SearchViewController
        searchViewController.presenter = SearchPresenter(view: searchViewController)
        
        let profileNagivationController = homeTabBarController.viewControllers![Router.PROFILE_TAB_POSITION] as! UINavigationController
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        if userLoggedIn {
            let profileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.PROFILE_VIEW_CONTROLLER) as! ProfileViewController
            profileViewController.presenter = ProfilePresenter(view: profileViewController)
            profileNagivationController.showViewController(profileViewController, sender: self)
        } else {
            let loginViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.LOGIN_VIEW_CONTROLLER) as! LoginViewController
            loginViewController.presenter = LoginPresenter(view: loginViewController)
            profileNagivationController.showViewController(loginViewController, sender: self)
        }
        
        let eventsNagivationController = homeTabBarController.viewControllers![Router.EVENTS_TAB_POSITION] as! UINavigationController
        let eventsViewController = eventsNagivationController.visibleViewController as! EventsViewController
        eventsViewController.presenter = EventsPresenter(view: eventsViewController)
        
        window.rootViewController = homeTabBarController
        window.makeKeyAndVisible()
    }
    
    static func showRepositoryDetails(viewController: UIViewController, repository: Repository) {
        
    }
    
}
