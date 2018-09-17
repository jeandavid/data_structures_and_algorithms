//
//  HeapSortTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class HeapSortTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var unsorted: [Int] = []
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
        unsorted = []
        maxHeap = nil
        minHeap = nil
        super.tearDown()
    }
    
    // MARK: Test Heap Sort On Array
    
    func testHeapSortByDescendingValues() {
        let sorted: [Int] = unsorted.sorted(by: >)
        let heapSorted: [Int] = unsorted.heapSorted()
        XCTAssertTrue(heapSorted == sorted)
    }
    
    func testHeapSortByAscendingValues() {
        let sorted: [Int] = unsorted.sorted(by: <)
        let heapSorted: [Int] = unsorted.heapSorted(desc: false)
        XCTAssertTrue(heapSorted == sorted)
    }
    
    // MARK: Test Sort Operation on Heap
    
    func testSortMaxHeap() {
        let items: [Int] = maxHeap.items
        let heapSorted: [Int] = maxHeap.sort()
        XCTAssertTrue(heapSorted == items.sorted(by: >))
    }
    
    func testSortMinHeap() {
        let items: [Int] = minHeap.items
        let heapSorted: [Int] = minHeap.sort()
        XCTAssertTrue(heapSorted == items.sorted(by: <))
    }
}
