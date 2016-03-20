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
    private static let USER_PROFILE_VIEW_CONTROLLER = "UserProfileViewController"
    private static let EDIT_USER_PROFILE_VIEW_CONTROLLER = "EditUserProfileViewController"
    
    private static let EVENTS_STORYBOARD = "Events"
    private static let EVENTS_VIEW_CONTROLLER = "EventsViewController"
    
    static func showHome(window: UIWindow) {
        let homeStoryboard = UIStoryboard(name: Router.HOME_STORYBOARD, bundle: nil)
        let homeTabBarController = homeStoryboard.instantiateViewControllerWithIdentifier(Router.HOME_TAB_BAR_CONTROLLER) as! UITabBarController
        
        let searchNagivationController = homeTabBarController.viewControllers![Router.SEARCH_TAB_POSITION] as! UINavigationController
        let searchViewController = searchNagivationController.visibleViewController as! SearchViewController
        searchViewController.presenter = SearchPresenter(view: searchViewController)
        
        let profileNagivationController = homeTabBarController.viewControllers![Router.PROFILE_TAB_POSITION] as! ProfileNavigatorController
        profileNagivationController.presenter = ProfileNavigatorPresenter(view: profileNagivationController)
        
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        if let user = UserRepository.sharedInstance().user {
            let userProfileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.USER_PROFILE_VIEW_CONTROLLER) as! UserProfileViewController
            userProfileViewController.presenter = UserProfilePresenter(view: userProfileViewController, repository: UserRepository.sharedInstance(), user: user)
            profileNagivationController.showViewController(userProfileViewController, sender: self)
        } else {
            let loginViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.LOGIN_VIEW_CONTROLLER) as! LoginViewController
            loginViewController.presenter = LoginPresenter(view: loginViewController, repository: UserRepository.sharedInstance())
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
    
    static func replaceAuthenticationWithProfile(navigatorController: UINavigationController, user: User) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let userProfileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.USER_PROFILE_VIEW_CONTROLLER) as! UserProfileViewController
        userProfileViewController.presenter = UserProfilePresenter(view: userProfileViewController, repository: UserRepository.sharedInstance(), user: user)
        navigatorController.setViewControllers([userProfileViewController], animated: false)
    }
    
    static func replaceProfileWithAuthentication(navigatorController: UINavigationController) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let loginViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.LOGIN_VIEW_CONTROLLER) as! LoginViewController
        loginViewController.presenter = LoginPresenter(view: loginViewController, repository: UserRepository.sharedInstance())
        navigatorController.setViewControllers([loginViewController], animated: false)
    }
    
    static func showEditProfile(navigatorController: UINavigationController, user: User) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let editUserProfileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.EDIT_USER_PROFILE_VIEW_CONTROLLER) as! EditUserProfileViewController
        editUserProfileViewController.presenter = EditUserProfilePresenter(view: editUserProfileViewController, repository: UserRepository.sharedInstance(), user: user)
        navigatorController.presentViewController(editUserProfileViewController, animated: true, completion: nil)
    }
    
    private static func showViewController(sender: UIViewController, showing: UIViewController) {
        if let navigationController = sender as? UINavigationController {
            navigationController.showDetailViewController(showing, sender: sender)
        } else {
            sender.showViewController(showing, sender: sender)
        }
    }
    
}
