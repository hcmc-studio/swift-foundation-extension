//
//  NSError+.swift
//
//
//  Created by Ji-Hwan Kim on 10/16/23.
//

import Foundation

extension NSError {
    public convenience init(domain: String, code: Int, underlying error: any Error) {
        self.init(domain: domain, code: code, userInfo: [NSUnderlyingErrorKey : error])
    }
}


