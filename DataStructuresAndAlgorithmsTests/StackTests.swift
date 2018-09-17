//
//  StackTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class StackTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var stack: Stack<Int>!
    var data: [Int]!
    
    override func setUp() {
        super.setUp()
        stack = Stack<Int>()
        data = []
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            data.append(random)
            stack.push(random)
        }
    }
    
    override func tearDown() {
        data = nil
        stack = nil
        super.tearDown()
    }
    
    // MARK: Test LIFO
    
    func testLIFO() {
        var index = data.count - 1
        while let last = stack.pop() {
            XCTAssertTrue(last == data[index])
            index -= 1
        }
    }
}
