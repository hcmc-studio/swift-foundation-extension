//
//  Result+.swift
//  
//
//  Created by Ji-Hwan Kim on 10/20/23.
//

import Foundation

extension Result {
    public static func wrap(throwable: () throws -> Success) -> Result<Success, any Error> {
        do {
            return .success(try throwable())
        } catch let error {
            return .failure(error)
        }
    }
    
    @available(iOS 13.0.0, *)
    @available(macOS 10.15.0, *)
    public static func wrap(throwable: () async throws -> Success) async -> Result<Success, any Error> {
        do {
            return .success(try await throwable())
        } catch let error {
            return .failure(error)
        }
    }
    
    public func successOrNil() -> Success? {
        switch self {
        case .success(let success): return success
        case .failure(_): return nil
        }
    }
    
    public func success(orElse transform: (Failure) -> Success) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let failure): return transform(failure)
        }
    }
    
    public func failureOrNil() -> Failure? {
        switch self {
        case .success(_): return nil
        case .failure(let failure): return failure
        }
    }
    
    public func failure(orElse transform: (Success) -> Failure) -> Failure {
        switch self {
        case .success(let success): return transform(success)
        case .failure(let failure): return failure
        }
    }
}
