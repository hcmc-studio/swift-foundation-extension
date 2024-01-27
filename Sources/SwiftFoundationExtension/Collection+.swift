//
//  Collection+.swift
//
//
//  Created by Ji-Hwan Kim on 11/12/23.
//

import Foundation

extension Collection {
    @inlinable
    public func get(orNil index: Index) -> Element? {
        return index < self.endIndex ? self[index] : nil
    }
    
    @inlinable
    public func get(orElse index: Index, _ supplier: () -> Element) -> Element {
        return get(orNil: index) ?? supplier()
    }
    
    @inlinable
    public func get(orThrow index: Index, _ supplier: () -> Error) throws -> Element {
        if let element = get(orNil: index) {
            return element
        } else {
            throw supplier()
        }
    }
}
