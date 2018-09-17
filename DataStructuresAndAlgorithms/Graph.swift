//
//  Graph.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 8/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

// MARK: Graph is a protocol that requires its conforming types to have vertices and edges.

public protocol Graph {
    associatedtype Element: Hashable
    
    var vertices: [Vertex<Element>] {get}
    var edges: [Edge<Element>] {get}
    
    mutating func addVertex(_ vertex: Vertex<Element>)
    mutating func addEdge(from tail: Vertex<Element>, to head: Vertex<Element>, with weight: Float)
    
    func neighbors(of vertex: Vertex<Element>) -> [Vertex<Element>]
    func outgoingEdges(from vertex: Vertex<Element>) -> [Edge<Element>]
}

public struct Vertex<Element: Hashable>: Equatable {
    var value: Element
}

extension Vertex: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(value)"
    }
}

public struct Edge<Element: Hashable>: Equatable {
    var tail: Vertex<Element>
    var head: Vertex<Element>
    var weight: Float = 1
}

extension Edge: Comparable {
    public static func < (lhs: Edge<Element>, rhs: Edge<Element>) -> Bool {
        return lhs.weight < rhs.weight
    }
}
