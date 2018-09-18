//
//  BinarySearchTree.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/9/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: Binary Search Tree
//
// A Binary Search Tree (BST) can be thought of as a dynamic sorted array.
// We would like to have the operations that a static array provides (search in log (n), select, min, max, prev, next in constant time)
// and have fast implementations for insertion and deletion (faster than linear time - what we get with a static array).
//
// Search Tree Property: At a given node, all nodes in the left sub tree should have smaller keys,
// all nodes in the right sub tree should have greater keys.
//
// This property closely relates to the ordering of an array and how binary search works.
// How it differs from the heap property highlights what it is trying to achieve.
// A heap wants to extract min, the heap property therefore makes it trivial to extract it: it’s at the root.
// A search tree wants to find an element.
//
// What operation does it support?
// -------------------------------
// A BST supports a very rich collection of operations: search, select, min/max, prev/next, insert, delete in logarithmic time.
//
// When to use a BST?
// --------------------
// When you have a dynamic set of comparable keys and you do a lot of processing using the ordering of those keys.
//
// If you only need to keep track of max or min and support insert/delete, then go with a heap.
// Although the benefits of a heap are not in the big O notation, the constant factors in space and time are going to be faster with a heap.
//
// If you only need to know what’s there and what’s not (i.e you need to support search, insert, delete but not min/max),
// then the structure of choice is the hash table where those operations take constant time.
//
// How to implement it?
// --------------------
// Notes on the height of a Binary Search Tree:
// If unbalanced, it’s height can be linear in the number of nodes, like a linked list.
// If balanced, it’s logarithmic in the number of nodes.
// Insertion and search running time are proportional to the height of the tree.

public struct BinarySearchTree<Key: Comparable, Element: Equatable> {
    public var root: BinarySearchNode<Key, Element>?
    
    public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// Inserts the element in time proportional to the height of the tree. Maintains the BST property.
    public mutating func insert(_ key: Key, with element: Element? = nil) {
        count += 1
        let node = BinarySearchNode(key, element)
        guard let root = self.root else {
            self.root = node
            return
        }
        let parent = findParent(key, in: root)
        if parent.key == key {
            // In case of duplicate keys, always insert left
            if let currentLeft = parent.leftChild {
                node.leftChild = currentLeft
            }
            parent.leftChild = node
        } else if parent.key > key {
            parent.leftChild = node
        } else {
            parent.rightChild = node
        }
        node.parent = parent
    }
    
    /// Returns the parent node for new node with key in time proportional to the height of the tree.
    private func findParent(_ key: Key, in root: BinarySearchNode<Key, Element>) -> BinarySearchNode<Key, Element> {
        if root.key > key {
            if let leftChild = root.leftChild {
                return findParent(key, in: leftChild)
            }
        } else if root.key < key{
            if let rightChild = root.rightChild {
                return findParent(key, in: rightChild)
            }
        }
        return root
    }
    
    /// Search for element with key in time proportional to the height of the tree.
    public func search(for key: Key) -> BinarySearchNode<Key, Element>? {
        return search(for: key, in: root)
    }
    
    private func search(for key: Key, in root: BinarySearchNode<Key, Element>?) -> BinarySearchNode<Key, Element>? {
        guard let root = root else {return nil}
        if root.key == key {return root}
        if root.key > key {
            return search(for: key, in: root.leftChild)
        } else {
            return search(for: key, in: root.rightChild)
        }
    }
    
    /// Search for node with min key in time proportional to the height of the tree.
    public func min() -> BinarySearchNode<Key, Element>? {
        var low = root
        while let lower = low?.leftChild {
            low = lower
        }
        return low
    }
    
    /// Search for node with max key in time proportional to the height of the tree.
    public func max() -> BinarySearchNode<Key, Element>? {
        var high = root
        while let higher = high?.rightChild {
            high = higher
        }
        return high
    }
}

public class BinarySearchNode<Key: Comparable, Element: Equatable> {
    var key: Key
    var element: Element?
    weak var parent: BinarySearchNode?
    var leftChild: BinarySearchNode?
    var rightChild: BinarySearchNode?
    init(_ key: Key, _ element: Element? = nil) {
        self.key = key
        self.element = element
    }
}

extension BinarySearchNode: Equatable {
    public static func == (lhs: BinarySearchNode<Key, Element>, rhs: BinarySearchNode<Key, Element>) -> Bool {
        return lhs.key == rhs.key
    }
}

extension BinarySearchNode: Comparable {
    public static func < (lhs: BinarySearchNode<Key, Element>, rhs: BinarySearchNode<Key, Element>) -> Bool {
        return lhs.key < rhs.key
    }
}
