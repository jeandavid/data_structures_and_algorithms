//
//  BreadthFirstSearch.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Breadth-First Search
//
// Finds all findable nodes from the starting node in linear time O(V+E).
// BFS explore nodes in layers.
// It can be used to compute the shortest path and the connected components of an undirected graph, in O(V+E) using a queue.

extension Graph {
    /**
         Finds all findable nodes from the starting node in linear time O(V+E).
         - Returns: Returns the explored vertices in order they were discovered.
     */
    public func breadthFirstSearch(from start: Vertex<Element>) -> [Vertex<Element>] {
        var explored = [Vertex<Element>]()
        var queue = Queue<Vertex<Element>>()
        queue.enqueue(start)
        while let next = queue.dequeue() {
            guard !explored.contains(next) else {continue}
            neighbors(of: next).forEach {queue.enqueue($0)}
            explored.append(next)
        }
        return explored
    }
}
