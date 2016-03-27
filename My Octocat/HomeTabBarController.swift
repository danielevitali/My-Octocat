//
//  HomeTabBarController.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/27/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class HomeTabBarController: UITabBarController, HomeViewContract {
    
    private static let LOGIN_TAB_POSITION = 1
    private static let USER_PROFILE_TAB_POSITION = 2
    
    var presenter: HomePresenterContract!
    var originalViewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalViewControllers = NSMutableArray(array: viewControllers!).flatMap({ $0 as? UIViewController })
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func showProfileTabHideLoginTab() {
        var items = [UIViewController]()
        items.append(originalViewControllers[0])
        items.append(originalViewControllers[HomeTabBarController.USER_PROFILE_TAB_POSITION])
        setViewControllers(items, animated: false)
    }
    
    func showLoginTabHideProfileTab() {
        var items = [UIViewController]()
        items.append(originalViewControllers[0])
        items.append(originalViewControllers[HomeTabBarController.LOGIN_TAB_POSITION])
        setViewControllers(items, animated: false)
    }
    
}