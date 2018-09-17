//
//  Stack.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 8/14/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Stack Data Structure
//
// A stack is a container of objects that are inserted and removed according to the LIFO principle.

/// Stack Data Structure that implements push and pop in constant time (amortized over many operations).
public struct Stack<Element> {
    private var elements: [Element] = []
    
    public var count: Int {
        return elements.count
    }
    
    /// Insert the element at the end of the array in constant time.
    public mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    /// Removes the last inserted element in constant time.
    public mutating func pop() -> Element? {
        guard !elements.isEmpty else {return nil}
        return elements.removeLast()
    }
}
