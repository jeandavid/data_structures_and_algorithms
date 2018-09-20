//
//  RandomizedSelectionTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/20/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class RandomizedSelectionTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var unsorted: [Int] = []
    
    override func setUp() {
        super.setUp()
        
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            unsorted.append(random)
        }
    }
    
    override func tearDown() {
        unsorted = []
        super.tearDown()
    }
    
    func testRandomizedSelection() {
        let orderStastitic = Int(arc4random_uniform(limit))
        let sorted = unsorted.sorted()
        if let randomizedSelection = unsorted.randomizedSelection(of: orderStastitic) {
            XCTAssertTrue(randomizedSelection == sorted[orderStastitic])
        }
    }
    
}
