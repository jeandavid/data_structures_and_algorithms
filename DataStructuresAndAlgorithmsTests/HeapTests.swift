//
//  HeapTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class HeapTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var maxHeap: Heap<Int>!
    var minHeap: Heap<Int>!
    
    override func setUp() {
        super.setUp()
        var unsorted: [Int] = []
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            unsorted.append(random)
        }
        maxHeap = Heap(items: unsorted)
        minHeap = Heap(items: unsorted, comparaisonFunction: <)
    }
    
    override func tearDown() {
        maxHeap = nil
        minHeap = nil
        super.tearDown()
    }
    
    // MARK: Test Heap Property
    
    func testMaxHeapProperty() {
        XCTAssertTrue(isMaxHeapPropertyVerified(maxHeap))
    }
    
    func testMinHeapProperty() {
        XCTAssertTrue(isMinHeapPropertyVerified(minHeap))
    }
    
    // MARK: Test Insert Operation
    
    func testInsertMaxHeap() {
        let newItem: Int = Int(arc4random_uniform(limit))
        maxHeap.insert(newItem)
        XCTAssertTrue(isMaxHeapPropertyVerified(maxHeap))
    }
    
    func testInsertMinHeap() {
        let newItem: Int = Int(arc4random_uniform(limit))
        minHeap.insert(newItem)
        XCTAssertTrue(isMinHeapPropertyVerified(minHeap))
    }
    
    // MARK: Test Extract Root Operation
    
    func testExtractMax() {
        let items: [Int] = maxHeap.items
        let max: Int? = maxHeap.extract()
        XCTAssertNotNil(max)
        XCTAssertTrue(isMaxHeapPropertyVerified(maxHeap))
        XCTAssertTrue(max == items.max())
    }
    
    func testExtractMin() {
        let items: [Int] = minHeap.items
        let min: Int? = minHeap.extract()
        XCTAssertNotNil(min)
        XCTAssertTrue(isMinHeapPropertyVerified(minHeap))
        XCTAssertTrue(min == items.min())
    }
}

extension HeapTests {
    fileprivate func isMaxHeapPropertyVerified<Element: Comparable>(_ maxHeap: Heap<Element>) -> Bool {
        for (parentIndex, parentItem) in maxHeap.items.enumerated() {
            let leftChildIndex = (2 * parentIndex) + 1
            let rightChildIndex = (2 * parentIndex) + 2
            guard leftChildIndex < maxHeap.items.count else {continue}
            guard rightChildIndex < maxHeap.items.count else {continue}
            if parentItem < maxHeap.items[leftChildIndex] || parentItem < maxHeap.items[rightChildIndex] {
                return false
            }
        }
        return true
    }
    
    fileprivate func isMinHeapPropertyVerified<Element: Comparable>(_ minHeap: Heap<Element>) -> Bool {
        for (parentIndex, parentItem) in minHeap.items.enumerated() {
            let leftChildIndex = (2 * parentIndex) + 1
            let rightChildIndex = (2 * parentIndex) + 2
            guard leftChildIndex < minHeap.items.count else {continue}
            guard rightChildIndex < minHeap.items.count else {continue}
            if parentItem > minHeap.items[leftChildIndex] || parentItem > minHeap.items[rightChildIndex] {
                return false
            }
        }
        return true
    }
}
