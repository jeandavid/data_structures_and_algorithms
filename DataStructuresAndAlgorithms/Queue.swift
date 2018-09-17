//
//  Queue.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 8/14/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Queue Data Structure that uses a doubly linked list.
//
// A queue is a container of objects that are inserted and removed according to the FIFO principle.
//
// How to implement it?
// --------------------
// Using a doubly linked list enables constant enqueing and dequeing out of the box.
// For instance, had we used an array, resizing would have been a linear operation.

/// Queue Data Structure that implements enqueue and dequeue in constant time.
public struct Queue<Element> {
    private var head: Node<Element>?
    private var tail: Node<Element>?
    
    public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// Enqueue an element in constant time
    public mutating func enqueue(_ element: Element) {
        let node = Node(element)
        if isEmpty {
            head = node
        } else {
            tail?.next = node
            node.previous = tail
        }
        tail = node
        count += 1
    }
    
    /// Dequeue an element in constant time
    public mutating func dequeue() -> Element? {
        guard !isEmpty else {return nil}
        let element: Element? = head?.value
        if count == 1 {
            tail = nil
        }
        head = head?.next
        count -= 1
        return element
    }
    
    /// Returns the element at index in linear time. Returns nil if index is out of bounds.
    public func element(at index: Int) -> Element? {
        guard !isEmpty && index > -1 && index < count else {return nil}
        var start = 0
        var node = head
        while start < index {
            start += 1
            node = node?.next
        }
        return node?.value
    }
}

fileprivate class Node<Element> {
    var value: Element
    weak var previous: Node?
    var next: Node?
    
    init(_ value: Element) {
        self.value = value
    }
}

// MARK: Queue Conforms to the Sequence Protocol

extension Queue: Sequence {
    public typealias Iterator = QueueIterator<Element>
    public func makeIterator() -> Iterator {
        return Iterator(queue: self)
    }
}

public struct QueueIterator<Element>: IteratorProtocol {
    private let queue: Queue<Element>
    private var index = 0
    
    init(queue: Queue<Element>) {
        self.queue = queue
    }
    
    public mutating func next() -> Element? {
        let element = queue.element(at: index)
        index += 1
        return element
    }
}
