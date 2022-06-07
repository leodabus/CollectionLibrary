//
//  SequenceTests.swift
//  
//
//  Created by Leonardo Dabus on 05/06/22.
//

import XCTest
@testable import CollectionLibrary

final class SequenceTests: XCTestCase {

    struct User {
        let name: String
        let age: Int
    }

    func testSum() throws {
        let sequence = [1,2,3,4,5]
        XCTAssertEqual(sequence.sum(), 15)
    }

    func testSumPredicate() throws {
        let users = [
            ("Steve", 45),
            ("Tim", 50)
        ].map(User.init)
        XCTAssertEqual(users.sum(\.age), 95)
    }
}
