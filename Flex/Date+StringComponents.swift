//
//  Date+StringDate.swift
//  Flex
//
//  Created by Varindra Hart on 3/3/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation

extension NSDate {

    func stringDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle

        return formatter.stringFromDate(self)
    }

    func time() -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle

        return formatter.stringFromDate(self)
    }

    func weekday() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E"

        return formatter.stringFromDate(self)
    }
}