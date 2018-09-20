//
//  InversionCountTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/20/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class InversionCountTests: XCTestCase {
    
    func testNoInversion() {
        let sorted: [Int] = Array(1..<100)
        XCTAssertTrue(sorted.inversionCount == 0)
    }
    
    func testOneInversion() {
        var sorted: [Int] = Array(1..<100)
        sorted.swapAt(50, 51)
        XCTAssertTrue(sorted.inversionCount == 1)
    }
    
    func testThreeInversion() {
        var sorted: [Int] = Array(1..<100)
        sorted.swapAt(50, 52)
        XCTAssertTrue(sorted.inversionCount == 3)
    }
    
}
