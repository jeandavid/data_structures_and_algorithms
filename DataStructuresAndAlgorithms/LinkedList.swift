//
//  LinkedList.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 7/23/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Linked List Data Structure with value semantic
//
// A downside of the value semantic is that operations like insert, delete require to copy the entire list.
// https://academy.realm.io/posts/try-swift-soroush-khanlou-sequence-collection/


/// Linked List Data Structure with value semantic
public indirect enum LinkedList<Element> {
    case node(element: Element, next: LinkedList<Element>)
    case end
}

extension LinkedList {
    /**
         Inserts node before self.
         - Returns: Returns the newly created node.
     */
    @discardableResult
    public func insert(_ element: Element) -> LinkedList {
        return LinkedList<Element>.node(element: element, next: self)
    }
}

// MARK: LinkedList Conforms to the Equatable Protocol whenvever Element does.

extension LinkedList: Equatable where Element: Equatable {
    public static func == (lhs: LinkedList, rhs: LinkedList) -> Bool {
        switch (lhs, rhs) {
        case (.end, .end):
            return true
        case let (.node(element: lhsElem, next: lhsNext), .node(element: rhsElem, next: rhsNext)):
            return lhsElem == rhsElem && lhsNext == rhsNext
        default:
            return false
        }
    }
}

// MARK: LinkedList Conforms to the Sequence Protocol

extension LinkedList: Sequence {
    public typealias Iterator = LinkedListIterator<Element>
    public func makeIterator() -> Iterator {
        return Iterator(current: self)
    }
}

public struct LinkedListIterator<Element>: IteratorProtocol {
    var current: LinkedList<Element>
    mutating public func next() -> Element? {
        switch current {
        case let .node(element, next):
            current = next
            return element
        case .end:
            return nil
        }
    }
}
