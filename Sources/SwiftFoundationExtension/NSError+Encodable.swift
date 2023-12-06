//
//  NSError+Encodable.swift
//  
//
//  Created by Ji-Hwan Kim on 12/6/23.
//

import Foundation

extension NSError: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: NSErrorCodingKeys.self)
        try container.encode(domain, forKey: .domain)
        try container.encode(code, forKey: .code)
        try container.encode(description, forKey: .description)
        try container.encode(localizedDescription, forKey: .localizedDescription)
        try container.encode(localizedFailureReason, forKey: .localizedFailureReason)
        try container.encode(localizedRecoveryOptions, forKey: .localizedRecoveryOptions)
        try container.encode(localizedRecoverySuggestion, forKey: .localizedRecoverySuggestion)
        try container.encode(helpAnchor, forKey: .helpAnchor)
        if #available(macOS 11.3, *), !underlyingErrors.isEmpty {
            try container.encode(underlyingErrors.map({ underlyingError in underlyingError as NSError }), forKey: .underlyingErrors)
        }
    }
}

private enum NSErrorCodingKeys: CodingKey {
    case domain,
         code,
         description,
         localizedDescription,
         localizedFailureReason,
         localizedRecoveryOptions,
         localizedRecoverySuggestion,
         helpAnchor,
         underlyingErrors
}
