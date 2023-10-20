//
//  BinaryInteger.swift
//
//
//  Created by Ji-Hwan Kim on 10/19/23.
//

import Foundation
import Algorithms

extension BinaryInteger {
    public var commaSeperated: String {
        String(String(self).reversed().chunks(ofCount: 3).joined(separator: ",").reversed())
    }
    
    public func ceilIfEven() -> Self {
        self + (self & 1)
    }
    
    public func abs() -> Self {
        if self < 0 {
            return self * -1
        } else {
            return self
        }
    }
}
