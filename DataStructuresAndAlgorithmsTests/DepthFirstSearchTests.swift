//
//  DepthFirstSearchTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/18/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class DepthFirstSearchTests: XCTestCase {
    
    var undirectedGraph: SparseGraph<String>!
    var directedGraph: SparseGraph<String>!
    
    override func setUp() {
        super.setUp()
        
        // MARK: Build undirected graph
        //         A
        //       /   \
        //     B       C
        //    / \     / \
        //   D   E - F - G
        //       |
        //       H
        //
        //       I - J
        //        \ /
        //         K
        //
        undirectedGraph = SparseGraph<String>(directed: false)
        let nodeA = Vertex(value: "a")
        let nodeB = Vertex(value: "b")
        let nodeC = Vertex(value: "c")
        let nodeD = Vertex(value: "d")
        let nodeE = Vertex(value: "e")
        let nodeF = Vertex(value: "f")
        let nodeG = Vertex(value: "g")
        let nodeH = Vertex(value: "h")
        let nodeI = Vertex(value: "i")
        let nodeJ = Vertex(value: "j")
        let nodeK = Vertex(value: "k")
        
        undirectedGraph.addEdge(from: nodeA, to: nodeB)
        undirectedGraph.addEdge(from: nodeA, to: nodeC)
        undirectedGraph.addEdge(from: nodeB, to: nodeD)
        undirectedGraph.addEdge(from: nodeB, to: nodeE)
        undirectedGraph.addEdge(from: nodeC, to: nodeF)
        undirectedGraph.addEdge(from: nodeC, to: nodeG)
        undirectedGraph.addEdge(from: nodeE, to: nodeH)
        undirectedGraph.addEdge(from: nodeE, to: nodeF)
        undirectedGraph.addEdge(from: nodeF, to: nodeG)
        undirectedGraph.addEdge(from: nodeI, to: nodeJ)
        undirectedGraph.addEdge(from: nodeJ, to: nodeK)
        undirectedGraph.addEdge(from: nodeK, to: nodeI)
    }
    
    override func tearDown() {
        undirectedGraph = nil
        super.tearDown()
    }
    
    func testFindsAllNodesInUndirectedGraphFromNodeA() {
        let accessibles = ["a", "b", "c", "d", "e", "f", "g", "h"]
        let explored = undirectedGraph.breadthFirstSearch(from: Vertex(value: "a")).map {$0.value}
        XCTAssertTrue(Set(accessibles).subtracting(explored).isEmpty)
        XCTAssertTrue(Set(accessibles).count == explored.count)
    }
    
    func testFindsAllNodesInUndirectedGraphFromNodeI() {
        let accessibles = ["i", "j", "k"]
        let explored = undirectedGraph.breadthFirstSearch(from: Vertex(value: "i")).map {$0.value}
        XCTAssertTrue(Set(accessibles).subtracting(explored).isEmpty)
        XCTAssertTrue(Set(accessibles).count == explored.count)
    }
    
}
