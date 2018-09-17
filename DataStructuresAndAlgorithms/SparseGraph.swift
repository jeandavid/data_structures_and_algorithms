//
//  SparseGraph.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: SparseGraph Data Structure

/// SparseGraph Data Structure uses an adjacency list to represent a graph. It requires O(V+E) memory ressources, which is good when E = O(V).
struct SparseGraph<Element: Hashable>: Graph {
    typealias AdjacencyList = [Vertex<Element> : LinkedList<Edge<Element>>]
    
    private var adjacencyList: AdjacencyList = [:]
    private let directed: Bool
    
    init(directed: Bool) {
        self.directed = directed
    }
    
    var vertices: [Vertex<Element>] {
        return Array(adjacencyList.keys)
    }
    
    var edges: [Edge<Element>] {
        var _edges: [Edge<Element>] = []
        for (_, linkedEdges) in adjacencyList {
            for edge in linkedEdges {
                _edges.append(edge)
            }
        }
        return _edges
    }
    
    /// Add a vertex to the graph in constant time
    mutating func addVertex(_ vertex: Vertex<Element>) {
        guard adjacencyList[vertex] == nil else {return}
        adjacencyList[vertex] = LinkedList.end
    }
    
    /// Add an edge to the graph in constant time
    mutating func addEdge(from tail: Vertex<Element>, to head: Vertex<Element>) {
        addEdge(from: tail, to: head, with: 1)
    }
    
    /// Add an edge to the graph in constant time
    mutating func addEdge(from tail: Vertex<Element>, to head: Vertex<Element>, with weight: Float) {
        addVertex(tail)
        addVertex(head)
        adjacencyList[tail] = adjacencyList[tail]?.insert(Edge(tail: tail, head: head, weight: weight))
        if !directed {
            adjacencyList[head] = adjacencyList[head]?.insert(Edge(tail: head, head: tail, weight: weight))
        }
    }
    
    func neighbors(of vertex: Vertex<Element>) -> [Vertex<Element>] {
        guard let edgeList: LinkedList<Edge> = adjacencyList[vertex] else {return []}
        var vertices: [Vertex<Element>] = []
        for edge in edgeList {
            vertices.append(edge.head)
        }
        return vertices
    }
    
    func outgoingEdges(from vertex: Vertex<Element>) -> [Edge<Element>] {
        guard let edgeList: LinkedList<Edge> = adjacencyList[vertex] else {return []}
        return Array(edgeList)
    }
}
