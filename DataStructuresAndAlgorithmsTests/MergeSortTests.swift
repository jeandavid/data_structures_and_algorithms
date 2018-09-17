//
//  MergeSortTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/7/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class MergeSortTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var unsorted: [Int] = []
    
    override func setUp() {
        super.setUp()
        var unsorted: [Int] = []
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            unsorted.append(random)
        }
    }
    
    override func tearDown() {
        unsorted = []
        super.tearDown()
    }
    
    // MARK: Test Merge Sort
    
    func testMergeSort() {
        let sorted: [Int] = unsorted.sorted()
        let mergeSorted: [Int] = unsorted.mergeSorted()
        XCTAssertTrue(mergeSorted == sorted)
    }
}

