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
    
    @available(iOS 14.5, *)
    @available(macOS 11.3, *)
    public func forEachUnderlying(action: (NSError) -> Void?) -> Void? {
        if action(self) == nil {
            return nil
        } else {
            for underlying in underlyingErrors {
                if (underlying as NSError).forEachUnderlying(action: action) == nil {
                    break
                }
            }
        }
        
        return ()
    }
    
    @available(iOS 14.5, *)
    @available(macOS 11.3, *)
    public func firstUnderlying(domain: String, code: Int) -> NSError? {
        var found: NSError? = nil
        forEachUnderlying { error in
            if error.domain == domain && error.code == code {
                found = error
                return nil
            }
        }
        
        return found
    }
}


