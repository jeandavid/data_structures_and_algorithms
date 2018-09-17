//
//  QueueTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class QueueTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var queue: Queue<Int>!
    var data: [Int]!
    
    override func setUp() {
        super.setUp()
        queue = Queue<Int>()
        data = []
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            data.append(random)
            queue.enqueue(random)
        }
    }
    
    override func tearDown() {
        data = nil
        queue = nil
        super.tearDown()
    }
    
    // MARK: Test FIFO
    
    func testFIFO() {
        var index = 0
        while let first = queue.dequeue() {
            XCTAssertTrue(first == data[index])
            index += 1
        }
    }
}
