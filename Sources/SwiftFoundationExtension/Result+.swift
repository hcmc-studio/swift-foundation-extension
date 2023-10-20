//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/20/23.
//

import Foundation

extension Result {
    public static func wrap(throwable: () throws -> Success) -> Result<Success, any Error> {
        do {
            let success = try throwable()
            
            return .success(success)
        } catch let error {
            return .failure(error)
        }
    }
}
