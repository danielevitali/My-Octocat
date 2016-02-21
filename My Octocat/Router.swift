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
    
    static func showHome(window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController")
        window.makeKeyAndVisible()
    }
    
}
