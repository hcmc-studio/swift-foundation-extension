//
//  Error+.swift
//
//
//  Created by Ji-Hwan Kim on 12/6/23.
//

import Foundation

extension Error {
    public func NSError() -> NSError {
        self as NSError
    }
}
