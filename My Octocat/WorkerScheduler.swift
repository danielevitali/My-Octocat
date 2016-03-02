//
//  WorkerScheduler.swift
//  My Octocat
//
//  Created by Daniele Vitali on 3/2/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation
import RxSwift

class WorkerScheduler: ConcurrentDispatchQueueScheduler {
    
    private static let instance = WorkerScheduler()
    
    class func sharedInstance() -> WorkerScheduler {
        return instance
    }
    
    private init() {
        let queue = dispatch_queue_create("Worker Scheduler Queue", nil)
        super.init(queue: queue)
    }
    
}