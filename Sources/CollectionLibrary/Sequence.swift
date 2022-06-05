//
//  File.swift
//  
//
//  Created by Leonardo Dabus on 05/06/22.
//

public extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

public extension Sequence  {
    /// Returns the total sum of all elements in the sequence based on predicate
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T {
        reduce(.zero) { $0 + predicate($1) }
    }
}
