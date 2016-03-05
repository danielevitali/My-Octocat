//
//  EventsPresenter.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/5/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

class EventsPresenter: EventsPresenterContract {
    
    let view: EventsViewContract
    
    init(view: EventsViewContract) {
        self.view = view
    }
    
}