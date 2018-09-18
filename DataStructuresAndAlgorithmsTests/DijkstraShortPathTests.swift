//
//  DijkstraShortPathTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by Jean-David Morgenstern-Peirolo on 9/18/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class DijkstraShortPathTests: XCTestCase {
    
    func testShortestPath() {
        var graph = SparseGraph<String>(directed: true)

        let nodeS = Vertex(value: "s")
        let nodeV = Vertex(value: "v")
        let nodeW = Vertex(value: "w")
        let nodeX = Vertex(value: "x")
        
        let edgeSV = Edge(tail: nodeS, head: nodeV, weight: 1)
        graph.addEdge(edgeSV)
        
        let edgeSW = Edge(tail: nodeS, head: nodeW, weight: 4)
        graph.addEdge(edgeSW)

        let edgeVW = Edge(tail: nodeV, head: nodeW, weight: 2)
        graph.addEdge(edgeVW)
        
        let edgeVX = Edge(tail: nodeV, head: nodeX, weight: 6)
        graph.addEdge(edgeVX)
        
        let edgeWX = Edge(tail: nodeW, head: nodeX, weight: 3)
        graph.addEdge(edgeWX)
        
        let result = graph.dijkstraShortestDistance(from: nodeS)
        XCTAssertTrue(result.count == 4)
        
        let shortestPathToV = [edgeSV]
        XCTAssertTrue(shortestPathToV == result[nodeV])
        
        let shortestPathToW = [edgeSV, edgeVW]
        XCTAssertTrue(shortestPathToW == result[nodeW])
        
        let shortestPathToX = [edgeSV, edgeVW, edgeWX]
        XCTAssertTrue(shortestPathToX == result[nodeX])
    }
    
    
}
