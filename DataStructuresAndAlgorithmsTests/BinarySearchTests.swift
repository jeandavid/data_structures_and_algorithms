//
//  BinarySearchTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class BinarySearchTests: XCTestCase {
    
    func testBinarySearch() {
        var ordered: [Int] = Array(0...999)
        let firstKey = 478
        let secondKey = 777
        let firstKeyIndex: Int? = ordered.binarySearch(for: firstKey)
        let secondKeyIndex: Int? = ordered.binarySearch(for: secondKey)
        XCTAssertNotNil(firstKeyIndex)
        XCTAssertNotNil(secondKeyIndex)
        XCTAssertTrue(ordered[firstKeyIndex!] == firstKey)
        XCTAssertTrue(ordered[secondKeyIndex!] == secondKey)
    }
    
}
