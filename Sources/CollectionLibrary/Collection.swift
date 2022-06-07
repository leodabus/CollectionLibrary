//
//  Collection.swift
//  
//
//  Created by Leonardo Dabus on 05/06/22.
//

import struct Foundation.Decimal
import Foundation.FoundationLegacySwiftCompatibility

public extension Collection {

    func indexedElements(body: ((index: Index, element: Element)) throws -> Void) rethrows {
        for element in indexedElements {
            try body(element)
        }
    }

    var indexedElements: Zip2Sequence<Indices, Self> {
        zip(indices, self)
    }

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence, Index> {
        sequence(state: startIndex) { lowerBound in
            guard lowerBound < endIndex else { return nil }
            let upperBound = index(lowerBound,
                offsetBy: maxLength,
                limitedBy: endIndex
            ) ?? endIndex
            defer { lowerBound = upperBound }
            return self[lowerBound..<upperBound]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element, Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer {
                let _ = formIndex(
                    &index,
                    offsetBy: n,
                    limitedBy: endIndex
                )
            }
            return self[index]
        }
    }

    func distance(to index: Index) -> Int {
        distance(
            from: startIndex,
            to: index
        )
    }
}

public extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
    /// Returns the average of all elements in the array
    func average<T: FloatingPoint>() -> T {
        isEmpty ? .zero : T(sum()) / T(count)
    }
}

public extension Collection where Element: FloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element {
        isEmpty ? .zero : sum() / Element(count)
    }
}

public extension Collection where Element == Decimal {
    /// Returns the average of all elements in the array
    func average() -> Decimal {
        isEmpty ? .zero : self.reduce(.zero, +) / Decimal(count)
    }
}

public extension Collection {
    /// Returns the average of all elements in the array
    func average<T: BinaryInteger>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }
    /// Returns the average of all elements in the array
    func average<T: BinaryInteger, F: FloatingPoint>(_ predicate: (Element) -> T) -> F {
        F(sum(predicate)) / F(count)
    }
    /// Returns the average of all elements in the array
    func average<T: FloatingPoint>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }

    func average(_ predicate: (Element) -> Decimal) -> Decimal {
        sum(predicate) / Decimal(count)
    }
}
