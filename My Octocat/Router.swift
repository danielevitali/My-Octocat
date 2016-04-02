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
    private static let LOGIN_TAB_POSITION = 1
    private static let USER_PROFILE_TAB_POSITION = 2
    
    private static let ACCOUNT_STORYBOARD = "Account"
    private static let LOGIN_VIEW_CONTROLLER = "LoginViewController"
    private static let USER_PROFILE_VIEW_CONTROLLER = "UserProfileViewController"
    private static let EDIT_USER_PROFILE_VIEW_CONTROLLER = "EditUserProfileViewController"
    
    private static let SEARCH_STORYBOARD = "Search"
    private static let SEARCH_VIEW_CONTROLLER = "SearchViewController"
    
    private static let REPOSITORY_STORYBOARD = "Repository"
    private static let REPOSITORY_VIEW_CONTROLLER = "RepositoryViewController"
    
    static func showHome(window: UIWindow) {
        let homeStoryboard = UIStoryboard(name: Router.HOME_STORYBOARD, bundle: nil)
        let homeTabBarController = homeStoryboard.instantiateViewControllerWithIdentifier(Router.HOME_TAB_BAR_CONTROLLER) as! HomeTabBarController
        homeTabBarController.presenter = HomePresenter(view: homeTabBarController)
        
        let searchNavigatorController = homeTabBarController.viewControllers![Router.SEARCH_TAB_POSITION] as! SearchNavigatorController
        searchNavigatorController.presenter = SearchNavigatorPresenter(view: searchNavigatorController)
        
        let loginNavigatorController = homeTabBarController.viewControllers![Router.LOGIN_TAB_POSITION] as! LoginNavigatorController
        loginNavigatorController.presenter = LoginNavigatorPresenter(view: loginNavigatorController)
        
        let userProfileNavigatorController = homeTabBarController.viewControllers![Router.USER_PROFILE_TAB_POSITION] as! UserProfileNavigatorController
        userProfileNavigatorController.presenter = UserProfileNavigatorPresenter(view: userProfileNavigatorController)
        
        window.rootViewController = homeTabBarController
        window.makeKeyAndVisible()
    }
    
    static func showSearchInNavigatorController(navigatorController: UINavigationController) {
        let searchStoryboard = UIStoryboard(name: Router.SEARCH_STORYBOARD, bundle: nil)
        let searchViewController = searchStoryboard.instantiateViewControllerWithIdentifier(Router.SEARCH_VIEW_CONTROLLER) as! SearchViewController
        searchViewController.presenter = SearchPresenter(view: searchViewController)
        navigatorController.viewControllers = [searchViewController]
    }
    
    static func showLoginInNavigatorController(navigatorController: UINavigationController) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let loginViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.LOGIN_VIEW_CONTROLLER) as! LoginViewController
        loginViewController.presenter = LoginPresenter(view: loginViewController, repository: UserRepository.sharedInstance())
        navigatorController.viewControllers = [loginViewController]
    }
    
    static func showUserProfileInNavigatorController(navigatorController: UINavigationController) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let userProfileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.USER_PROFILE_VIEW_CONTROLLER) as! UserProfileViewController
        userProfileViewController.presenter = UserProfilePresenter(view: userProfileViewController)
        navigatorController.viewControllers = [userProfileViewController]
    }
    
    static func showEditProfile(navigationController: UINavigationController, user: User) {
        let accountStoryboard = UIStoryboard(name: Router.ACCOUNT_STORYBOARD, bundle: nil)
        let editUserProfileViewController = accountStoryboard.instantiateViewControllerWithIdentifier(Router.EDIT_USER_PROFILE_VIEW_CONTROLLER) as! EditUserProfileViewController
        editUserProfileViewController.presenter = EditUserProfilePresenter(view: editUserProfileViewController, repository: UserRepository.sharedInstance(), user: user)
        navigationController.presentViewController(editUserProfileViewController, animated: true, completion: nil)
    }
    
    static func showRepository(navigationController: UINavigationController, repository: Repository) {
        let repositoryStoryboard = UIStoryboard(name: Router.REPOSITORY_STORYBOARD, bundle: nil)
        let repositoryViewController = repositoryStoryboard.instantiateViewControllerWithIdentifier(Router.REPOSITORY_VIEW_CONTROLLER) as! RepositoryViewController
        repositoryViewController.presenter = RepositoryPresenter(view: repositoryViewController, repo: repository)
        navigationController.pushViewController(repositoryViewController, animated: true)
    }
    
    private static func showViewController(sender: UIViewController, showing: UIViewController) {
        if let navigationController = sender as? UINavigationController {
            navigationController.showDetailViewController(showing, sender: sender)
        } else {
            sender.showViewController(showing, sender: sender)
        }
    }
    
    
    
}
