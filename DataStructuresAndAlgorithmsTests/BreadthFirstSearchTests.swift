//
//  BreadthFirstSearchTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class BreadthFirstSearchTests: XCTestCase {
    
    var graph: SparseGraph<String>!
    
    override func setUp() {
        super.setUp()
        
        graph = SparseGraph<String>(directed: false)
        let nodeA = Vertex(value: "a")
        let nodeB = Vertex(value: "b")
        let nodeC = Vertex(value: "c")
        let nodeD = Vertex(value: "d")
        let nodeE = Vertex(value: "e")
        let nodeF = Vertex(value: "f")
        let nodeG = Vertex(value: "g")
        let nodeH = Vertex(value: "h")
        
        graph.addEdge(from: nodeA, to: nodeB)
        graph.addEdge(from: nodeA, to: nodeC)
        graph.addEdge(from: nodeB, to: nodeD)
        graph.addEdge(from: nodeB, to: nodeE)
        graph.addEdge(from: nodeC, to: nodeF)
        graph.addEdge(from: nodeC, to: nodeG)
        graph.addEdge(from: nodeE, to: nodeH)
        graph.addEdge(from: nodeE, to: nodeF)
        graph.addEdge(from: nodeF, to: nodeG)
    }
    
    override func tearDown() {
        graph = nil
        super.tearDown()
    }
    
    func testFindsAllNodesFromNodeA() {
        let layers = [["a"], ["b", "c"], ["d", "e", "f", "g"], ["h"]]
        let explored = graph.breadthFirstSearch(from: Vertex(value: "a")).map {$0.value}
        XCTAssertTrue(Set(layers.flatMap({$0})).subtracting(explored).isEmpty)
    }
    
    func testFindsAllNodesFromNodeB() {
        let layers = [["b"], ["a", "d", "e"], ["c", "h", "f"], ["g"]]
        let explored = graph.breadthFirstSearch(from: Vertex(value: "b")).map {$0.value}
        XCTAssertTrue(Set(layers.flatMap({$0})).subtracting(explored).isEmpty)
    }
    
}
