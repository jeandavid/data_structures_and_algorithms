//
//  LinkedListR.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 16/06/20.
//  Copyright © 2020 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Linked List Data Structure with ref semantic
//
// var linkedList = LinkedList<String>()
//  do {
//      try linkedList.insert("JD")
//      try linkedList.insert("Elish")
//      try linkedList.insert("Sharon")
//      try linkedList.insert("dog")
//      try linkedList.insert("Danielle")
//      try linkedList.extract("dog")
//      for name in linkedList {
//          print(name)
//      }
//  }
//  catch let error {
//      print(error.localizedDescription)
//  }

import Foundation

enum LinkedListError: Error {
    case alreadyInserted
    case notFound
}

class LinkedList<Element: Equatable> {
    
    var start: Node<Element>?
    
    /// O(n)
    func insert(_ element: Element) throws {
        let node = Node(element: element)
        guard find(element) == nil else {
            throw LinkedListError.alreadyInserted
        }
        guard let first = start else {
            start = node
            return
        }
        var current = first
        while let next = current.next {
            current = next
        }
        current.next = node
        node.previous = current
    }
    
    /// O(n)
    func extract(_ element: Element) throws {
        guard let node = find(element) else {
            throw LinkedListError.notFound
        }
        if let previous = node.previous, let next = node.next {
            previous.next = next
            next.previous = previous
        }
        if node.next == nil {
            node.previous?.next = nil
        }
    }
    
    /// O(n)
    private func find(_ element: Element) -> Node<Element>? {
        guard var current = start else {
            return nil
        }
        while let next = current.next {
            if next.element == element {
                return next
            }
            current = next
        }
        return nil
    }
}

class Node<Element: Equatable> {
    weak var previous: Node?
    var next: Node?
    let element: Element
    
    init(element: Element) {
        self.element = element
    }
}

class LinkedListIterator<Element: Equatable>: IteratorProtocol {
    var current: Node<Element>?
    
    init(start: Node<Element>?) {
        self.current = start
    }
    
    func next() -> Element? {
        defer {
            current = current?.next
        }
        return current?.element
    }
}

extension LinkedList: Sequence {
    func makeIterator() -> LinkedListIterator<Element> {
        return LinkedListIterator<Element>(start: start)
    }
}
