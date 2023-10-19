//
//  Optional+.swift
//
//
//  Created by Ji-Hwan Kim on 10/19/23.
//

import Foundation

extension Optional {
    public func describe() -> String {
        if let self = self {
            return .init(describing: self)
        } else {
            return "<nil>"
        }
    }
    
    public func describe(onNil: String) -> String {
        if let self = self {
            return .init(describing: self)
        } else {
            return onNil
        }
    }
}
