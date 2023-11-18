//
//  String+.swift
//
//
//  Created by Ji-Hwan Kim on 10/19/23.
//

import Foundation

extension String {
    public static func *(_ lhs: String, _ rhs: Int) -> String {
        var acc = ""
        for _ in 0..<rhs {
            acc += lhs
        }
        
        return acc
    }
}
