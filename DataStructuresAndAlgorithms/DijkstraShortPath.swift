//
//  DijkstraShortPath.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Dijkstra Single Source Shortest Path

extension Graph {
    /**
         Finds the shortest path distance between a source vertex to every other vertices in O(E * log V). Uses a heap data structure to reach this running time.
     
         - Precondition: We assume that there is a path to every other vertices and that all the edges have non negative weights.
         - Returns: Returns the shortest path for each vertex.
     */
    public func dijkstraShortestDistance(from source: Vertex<Element>) -> [Vertex<Element>: [Edge<Element>?]] {
        // init
        var explored: Set<Vertex<Element>> = Set([source])
        var paths: [Vertex<Element>: [Edge<Element>?]] = [source: []]
        var heap: Heap<DijkstraNode<Element>> = buildHeap(from: source)
        // Extract vertex with min score from heap in constant time
        while let node: DijkstraNode = heap.extract() {
            explored.insert(node.vertex)
            paths[node.vertex] = node.path
            let crossingEdges = edges.filter { $0.tail == node.vertex && !explored.contains($0.head)}
            // for each edge whose tail is the extracted min node.vertex and whose head is unexplored
            crossingEdges.forEach { (edge) in
                guard let removedNode: DijkstraNode = heap.extract(DijkstraNode(vertex: edge.head, path: [])) else {return}
                let pathWithMinScore = removedNode.score < (node.score + edge.weight) ? removedNode.path : node.path + [edge]
                let nodeToInsert = DijkstraNode(vertex: edge.head, path: pathWithMinScore)
                heap.insert(nodeToInsert)
            }
        }
        return paths
    }
    
    fileprivate func buildHeap(from source: Vertex<Element>) -> Heap<DijkstraNode<Element>> {
        let unexplored = Set(vertices).subtracting([source])
        let crossingEdges = edges.filter { $0.tail == source && unexplored.contains($0.head) }
        let items: [DijkstraNode] = unexplored.map {
            (vertex) -> DijkstraNode<Element> in
            let minEdge: Edge<Element>? = crossingEdges.filter { $0.head == vertex }.min()
            return DijkstraNode(vertex: vertex, path: [minEdge])
        }
        return Heap(items: items)
    }
}


public struct DijkstraNode<Element> where Element: Hashable {
    let vertex: Vertex<Element>
    /// The path is the shortest path from source if it exists
    var path: [Edge<Element>?]
    var score: Float {
        return path.reduce(0, { (result, edge) -> Float in
            return result + (edge?.weight ?? Float.infinity)
        })
    }
}

extension DijkstraNode: Hashable {
    public var hashValue: Int {
        return vertex.hashValue
    }
}

extension DijkstraNode: Equatable {
    public static func == (lhs: DijkstraNode<Element>, rhs: DijkstraNode<Element>) -> Bool {
        return lhs.vertex == rhs.vertex
    }
}

extension DijkstraNode: Comparable {
    public static func < (lhs: DijkstraNode<Element>, rhs: DijkstraNode<Element>) -> Bool {
        return lhs.score > rhs.score
    }
}
