//
//  SwiftFoundationExtension.swift
//  
//
//  Created by Ji-Hwan Kim on 1/29/24.
//

import Foundation

public struct SwiftFoundationExtension {
    private init() {}
    
    public static let domain = "studio.hcmc.foundation"
    
    public struct RequestBuilder {
        private init() {}
        
        public static let domain = SwiftFoundationExtension.domain + ".requestBuilder"
        
        @available(iOS 14.5, *)
        public static func decodingError(error0: Error, error1: Error) -> NSError {
            .init(
                domain: domain,
                code: 0,
                userInfo: [NSMultipleUnderlyingErrorsKey : [ error0, error1 ]]
            )
        }
    }
}
