//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/17/23.
//

import Foundation
import Algorithms

extension BinaryInteger {
    public func insertComma() -> String {
        String(String(self).reversed().chunks(ofCount: 3).joined(separator: ",").reversed())
    }
}
