//
//  Heap.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 7/24/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Heap Data Structure
//
// A heap, also called a priority queue, is a container for objects that have comparable keys.
//
// Heap Max Property: At a given node, all chidlren nodes have greater keys. 
//
// What operation does it support?
// -------------------------------
// A heap supports insertion and extract-min (remove object with minimum value) in O(log n).
// A heap can be implemented with extract-max or extract-min.
// A heap also has a heapify operation, usually to initialize itself. It supports a batched insertion in linear time - instead of O(n log n) for n regular insertion.
// Additionally a heap may delete an object in O(log n).
//
// When to use a heap?
// --------------------
// Because your program is doing repeated minimum computation, especially is extensive search.
//
// How to implement it?
// --------------------
// Conceptually, a heap can be seen as a tree that is: binary (each node has at most two children) and as complete as possible (each level is full except for the leaves that might be partially filled).
// However it’s more efficient to implement it as an array.

/// Heap Data Structure that implements insert and extract in logarithmic time.
/// Make sure you initialize the heap with a comparator function that statisfies your min or max requirement.
/// If your item conforms the Comparable protocol, then by default a max heap will be implemented.
public struct Heap<Item> where Item: Hashable {
    public typealias Comparator<T> =  (T, T) -> Bool
    
    fileprivate var itemIndexes: [Item: Int] = [:]
    fileprivate (set) var items: [Item]
    fileprivate let comparaisonFunction: Comparator<Item>
    
    public init<S: Sequence>(elements: S, comparaisonFunction: @escaping Comparator<Item>) where S.Element == Item {
        self.init(items: Array(elements), comparaisonFunction: comparaisonFunction)
    }
    
    public init(items: [Item] = [], comparaisonFunction: @escaping Comparator<Item>) {
        self.items = items
        self.comparaisonFunction = comparaisonFunction
        self.buildMaxHeap()
    }
    
    /// Inserts the item in log (n) time. Maintains the heap property.
    public mutating func insert(_ item: Item) {
        items.append(item)
        shiftUp(at: count - 1)
    }
    
    /// Extracts the root item (min or max, depends on your comparator function) in log (n) time. Maintains the heap property.
    public mutating func extract() -> Item? {
        return extract(at: 0)
    }
    
    /// Extracts the item at index in log (n) time. Maintains the heap property.
    public mutating func extract(_ item: Item) -> Item? {
        guard let index = itemIndexes[item] else {return nil}
        return extract(at: index)
    }
    
    /************************
     **                     **
     **      HELPERS        **
     **                     **
     *************************/
    fileprivate var isEmpty: Bool {
        return items.isEmpty
    }
    
    fileprivate var count: Int {
        return items.count
    }
    
    fileprivate func isRoot(_ index: Int) -> Bool {
        return index == 0
    }
    
    fileprivate func leftChild(of parent: Int) -> Int {
        return (2 * parent) + 1
    }
    
    fileprivate func rightChild(of parent: Int) -> Int {
        return (2 * parent) + 2
    }
    
    // Integer division!
    fileprivate func parent(of child: Int) -> Int {
        return (child - 1) / 2
    }
    
    fileprivate func isLarger(at first: Int, than second: Int) -> Bool {
        return comparaisonFunction(items[first], items[second])
    }
    
    fileprivate func largest(of parent: Int, and child: Int) -> Int {
        guard child < count else {return parent}
        return isLarger(at: parent, than: child)
            ? parent
            : child
    }
    
    /// Returns the largest index of {parent, rightChild, leftChild}
    fileprivate func largest(for parent: Int) -> Int {
        let rightChild: Int = self.rightChild(of: parent)
        let leftChild: Int = self.leftChild(of: parent)
        return largest(of: largest(of: parent, and: leftChild), and: rightChild)
    }
    
    fileprivate mutating func swapItem(at first: Int, and second: Int) {
        guard first != second else {return}
        items.swapAt(first, second)
        itemIndexes[items[first]] = first
        itemIndexes[items[second]] = second
    }
    
    /// Recurively bubbles up from index, maintaining the heap property.
    fileprivate mutating func shiftUp(at index: Int) {
        let parent: Int = self.parent(of: index)
        guard !isRoot(index), isLarger(at: index, than: parent) else {return}
        swapItem(at: index, and: parent)
        shiftUp(at: parent)
    }
    
    /// Recurively bubbles down from index, maintaining the heap property.
    fileprivate mutating func shiftDown(at index: Int) {
        let largestIndex: Int = largest(for: index)
        guard index != largestIndex else {return}
        swapItem(at: index, and: largestIndex)
        shiftDown(at: largestIndex)
    }
    
    /// Extracts the item at index in log (n) time. Maintains the heap property.
    fileprivate mutating func extract(at index: Int) -> Item? {
        guard index < count else {return nil}
        swapItem(at: index, and: count - 1)
        let item: Item = items.removeLast()
        if !isEmpty {
            shiftDown(at: index)
        }
        return item
    }
    
    fileprivate mutating func maxHeapify(at index: Int) {
        let largestIndex: Int = largest(for: index)
        guard index != largestIndex else {return}
        swapItem(at: index, and: largestIndex)
        maxHeapify(at: largestIndex)
    }
    
    fileprivate mutating func buildMaxHeap() {
        for index in (0 ..< count / 2).reversed() {
            maxHeapify(at: index)
        }
    }
}

extension Heap where Item: Comparable {
    public init<S: Sequence>(elements: S) where S.Element == Item {
        self.init(items: Array(elements))
    }
    
    public init(items: [Item] = []) {
        self.init(items: items, comparaisonFunction: >)
    }
}
