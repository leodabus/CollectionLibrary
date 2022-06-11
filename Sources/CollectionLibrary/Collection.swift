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

extension Collection where Element: Equatable {
    
    func firstIndex(after element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        return self.index(after: index)
    }
    
    func subSequence(from element: Element) -> SubSequence? {
        guard let index = firstIndex(of: element) else { return nil }
        return self[index...]
    }
    func subSequence(after element: Element) -> SubSequence? {
        guard let index = firstIndex(after: element) else { return nil }
        return self[index...]
    }
    
    func subSequence(upTo element: Element) -> SubSequence? {
        guard let index = firstIndex(after: element) else { return nil }
        return self[..<index]
    }
    func subSequence(upThrough element: Element) -> SubSequence? {
        guard let index = firstIndex(of: element) else { return nil }
        return self[...index]
    }
    
    func subSequence(from element: Element, upTo: Element) -> SubSequence? {
        guard
            let lower = firstIndex(of: element),
            let upper = self[lower...].firstIndex(of: upTo)
        else { return nil }
        return self[lower..<upper]
    }
    func subSequence(from element: Element, upThrough: Element) -> SubSequence? {
        guard
            let lower = firstIndex(of: element),
            let upper = self[lower...].firstIndex(of: upThrough)
        else { return nil }
        return self[lower...upper]
    }
    
    func subSequence(after element: Element, upTo: Element) -> SubSequence? {
        guard
            let lower = firstIndex(after: element),
            let upper = self[lower...].firstIndex(of: upTo)
        else { return nil }
        return self[lower..<upper]
    }
    func subSequence(after element: Element, upThrough: Element) -> SubSequence? {
        guard
            let lower = firstIndex(after: element),
            let upper = self[lower...].firstIndex(of: upThrough)
        else { return nil }
        return self[lower...upper]
    }
}

extension Collection {
    func dropLast(while predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        guard let index = try indices.reversed().first(where: { try !predicate(self[$0]) }) else {
            return self[startIndex..<startIndex]
        }
        return self[...index]
    }
}
