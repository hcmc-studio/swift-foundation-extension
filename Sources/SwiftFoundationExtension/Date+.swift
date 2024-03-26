//
//  Date+.swift
//
//
//  Created by Ji-Hwan Kim on 3/25/24.
//

import Foundation

extension Date {
    public init(date: Date, time: TimeInterval) {
        self.init(timeIntervalSince1970: TimeInterval((Int(date.timeIntervalSince1970) / 86400) * 86400) + time)
    }
    
    public var startOfDay: Date {
        .init(date: self, time: 0)
    }
    
    public var startOfNextDay: Date {
        .init(date: self, time: 86400)
    }
}
