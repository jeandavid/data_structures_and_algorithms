//
//  QuickSortTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/20/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class QuickSortTests: XCTestCase {
    
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
    
    // MARK: Test Partition Around Pivot
    
    func testPartitionAroundPivot() {
        let pivotIndex = Int(arc4random_uniform(limit))
        let pivot: Int = unsorted[pivotIndex]
        let finalPivotIndex = unsorted.partitionAroundPivot(from: 0, to: unsorted.count, around: pivotIndex)
        if let maxBeforePivot = unsorted[0..<finalPivotIndex].max() {
            XCTAssertTrue(maxBeforePivot <= pivot)
        }
        if let minAfterPivot = unsorted[finalPivotIndex..<unsorted.count].min() {
            XCTAssertTrue(minAfterPivot >= pivot)
        }
    }
    
    // MARK: Test Quick Sort
    
    func testQuickSort() {
        let sorted: [Int] = unsorted.sorted()
        unsorted.quickSort()
        XCTAssertTrue(sorted == unsorted)
    }
    
}
