//
//  Dictionary+.swift
//
//
//  Created by Ji-Hwan Kim on 11/6/23.
//

import Foundation

extension Dictionary {
    public mutating func insert(key: Key, overriding value: Value) {
        self[key] = value
    }
    
    public func inserting(key: Key, overriding value: Value) -> Self {
        var s = self
        s[key] = value
        
        return s
    }
}
