//
//  DepthFirstSearch.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Depth-First Search
//
// Finds all findable nodes from the starting node in linear time O(V+E).
// DFS (Depth First Search) explores nodes aggressively like a maze, backtracking only when necessary.
// It can be used to compute the topological ordering of a DAG, but cannot be used to compute the shortest path.
// It can also compute the connected components of a directed graph, in O(n+m) using a stack or via recursion.

extension Graph {
    /**
         Finds all findable nodes from the starting node in linear time O(V+E).
         - Returns: Returns the explored vertices in order they were discovered.
     */
    public func depthFirstSearch(from start: Vertex<Element>) -> [Vertex<Element>] {
        var explored: [Vertex<Element>] = []
        var stack = Stack<Vertex<Element>>()
        stack.push(start)
        while let next = stack.pop() {
            guard !explored.contains(next) else {continue}
            neighbors(of: next).forEach {stack.push($0)}
            explored.append(next)
        }
        return explored
    }
}
