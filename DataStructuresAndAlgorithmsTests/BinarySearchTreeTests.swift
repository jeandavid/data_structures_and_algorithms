//
//  BinarySearchTreeTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/18/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class BinarySearchTreeTests: XCTestCase {
    
    let limit: UInt32 = 1000
    var bst: BinarySearchTree<Int, Int>!
    
    override func setUp() {
        super.setUp()
    
        bst = BinarySearchTree<Int, Int>()
        
        for _ in 0..<limit {
            let random = Int(arc4random_uniform(limit))
            bst.insert(random)
        }
    }
    
    override func tearDown() {
        bst = nil
        super.tearDown()
    }
    
    // MARK: Test Binary Search Tree Property
    
    func testBinarySearchTreeProperty() {
        XCTAssertTrue(isBinarySearchTreePropertyVerified(bst))
    }
    
    // MARK: Test Insert Operation
    
    func testInsert() {
        let random = Int(arc4random_uniform(limit))
        bst.insert(random)
        XCTAssertTrue(isBinarySearchTreePropertyVerified(bst))
    }
    
    // MARK: Test Search Operation
    
    func testUnsuccessfulSearch() {
        let invalidKey = Int(limit + 1)
        let found = bst.search(for: invalidKey)
        XCTAssertNil(found)
    }
    
    func testSuccessfulSearch() {
        let random = Int(arc4random_uniform(limit))
        bst.insert(random)
        let found = bst.search(for: random)
        XCTAssertNotNil(found)
    }
    
    // MARK: Test Max Operation
    
    func testMax() {
        let max = Int(limit + 1)
        bst.insert(max)
        let result = bst.max()
        XCTAssertNotNil(result)
        XCTAssertTrue(max == result!.key)
    }
    
    func testMin() {
        let min = -1
        bst.insert(min)
        let result = bst.min()
        XCTAssertNotNil(result)
        XCTAssertTrue(min == result!.key)
    }
    
}

extension BinarySearchTreeTests {
    func isBinarySearchTreePropertyVerified<Key: Comparable, Element: Equatable>(_ bst: BinarySearchTree<Key, Element>) -> Bool {
        guard let root = bst.root else {return true}
        var queue = Queue<BinarySearchNode<Key, Element>>()
        queue.enqueue(root)
        while let next = queue.dequeue() {
            if let leftChild = next.leftChild {
                let allLeftNodes = allNodes(from: leftChild)
                for leftNode in allLeftNodes {
                    // smaller or equal (insert left policy!)
                    guard leftNode <= next else {return false}
                }
                queue.enqueue(leftChild)
            }
            if let rightChild = next.rightChild {
                let allRightNodes = allNodes(from: rightChild)
                for rightNode in allRightNodes {
                    // strictly greater (insert left policy!)
                    guard rightNode > next else {return false}
                }
                queue.enqueue(rightChild)
            }
        }
        return true
    }
    
    func allNodes<Key: Comparable, Element: Equatable>(from root: BinarySearchNode<Key, Element>) -> [BinarySearchNode<Key, Element>] {
        var nodes = [BinarySearchNode<Key, Element>]()
        var queue = Queue<BinarySearchNode<Key, Element>>()
        queue.enqueue(root)
        while let next = queue.dequeue() {
            if let leftChild = next.leftChild {
                queue.enqueue(leftChild)
            }
            if let rightChild = next.rightChild {
                queue.enqueue(rightChild)
            }
            nodes.append(next)
        }
        return nodes
    }
}


