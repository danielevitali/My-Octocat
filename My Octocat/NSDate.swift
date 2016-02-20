//
//  NSDate.swift
//  My Octocat
//
//  Created by Daniele Vitali on 2/20/16.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

public extension NSDate {
    
    private static let ISO8601_PATTERN = "yyyy-MM-ddTHH:mm:ssZ"
    
    public static func ISOStringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = ISO8601_PATTERN
        return dateFormatter.stringFromDate(date)
    }
    
    public static func dateFromISOString(string: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = ISO8601_PATTERN
        return dateFormatter.dateFromString(string)!
    }
}