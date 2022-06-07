//
//  CollectionTests.swift
//  
//
//  Created by Leonardo Dabus on 05/06/22.
//

import XCTest
@testable import CollectionLibrary

final class CollectionTests: XCTestCase {

    struct User {
        let name: String
        let age: Int
    }

    struct Lap {
        let number: Int
        let duration: Double
    }

    struct Product {
        let id: String
        let price: Decimal
    }

    func testIndexedElements() throws {
        let list =  [100, 200, 300, 400, 500]
        var position = 2
        var value = 300
        list.dropFirst(2).indexedElements { index, element in
            XCTAssertEqual(index, position)
            XCTAssertEqual(element, value)
            position += 1
            value += 100
        }
    }

    func testIndexedElementsProperty() throws {
        let list =  [100, 200, 300, 400, 500]
        var position = 2
        var value = 300
        for (index, element) in list.dropFirst(2).indexedElements { 
            XCTAssertEqual(index, position)
            XCTAssertEqual(element, value)
            position += 1
            value += 100
        }
    }

    func testUnfoldSubSequencesLimitedTo() throws {
        let sequence = [1, 2, 3, 4, 5]
        let unfoldSubSequences = sequence.unfoldSubSequences(limitedTo: 2)
        XCTAssertEqual(Array(unfoldSubSequences), [[1, 2], [3, 4], [5]])
    }

    func testEveryN() throws {
        let sequence = Array(1...10)
        let unfoldSequence = sequence.every(n: 3)
        XCTAssertEqual(Array(unfoldSequence), [1, 4, 7, 10])
    }

    func testDistanceTo() throws {
        let string = "🇺🇸🇺🇸🇧🇷🇺🇸🇺🇸"
        let indexUSA = string.firstIndex(of: "🇺🇸")!
        let distanceUSA = string.distance(to: indexUSA)
        XCTAssertEqual(distanceUSA, 0)
        let indexBRA = string.firstIndex(of: "🇧🇷")!
        let distanceBRA = string.distance(to: indexBRA)
        XCTAssertEqual(distanceBRA, 2)
    }

    func testAverage() throws {
        let sequence = [1, 2, 3, 4, 5]
        let average = sequence.average()
        XCTAssertEqual(average, 3)
    }

    func testAverageBinaryIntegerToFloatingPoint() throws {
        let sequence = [1, 2, 3, 4, 5]
        let average: Double = sequence.average()
        XCTAssertEqual(average, 3)
    }

    func testAverageFloatingPoint() throws {
        let sequence: [Double] = [1, 2, 3, 4, 5]
        let average: Double = sequence.average()
        XCTAssertEqual(average, 3)
    }

    func testAverageDecimal() throws {
        let sequence: [Decimal] = [1, 2, 3, 4, 5]
        let average: Decimal = sequence.average()
        XCTAssertEqual(average, 3)
    }

    func testtAveragePredicateBinaryInteger() throws {
        let users = [
            ("Steve", 45),
            ("Tim", 50)
        ].map(User.init)
        let average = users.average(\.age)
        XCTAssertEqual(average, 47)
    }

    func testtAveragePredicateBinaryIntegerToFloatingPoint() throws {
        let users = [
            ("Steve", 45),
            ("Tim", 50)
        ].map(User.init)
        let average: Double = users.average(\.age)
        XCTAssertEqual(average, 47.5)
    }

    func testtAveragePredicateFloatingPoint() throws {
        let laps = [
            (1, 67.5),
            (2, 68.0),
            (2, 68.5)
        ].map(Lap.init)
        let average: Double = laps.average(\.duration)
        XCTAssertEqual(average, 68.0)
    }

    func testtAveragePredicateDecimal() throws {
        let products = [
            ("iPhone", Decimal(string: "8638.17")!),
            ("Galaxy", Decimal(string: "10680.18")!),
            ("Pixel", Decimal(string: "5959.95")!)
        ].map(Product.init)
        let average = products.average(\.price)
        XCTAssertEqual(average, Decimal(string: "8426.1")!)
    }
}
