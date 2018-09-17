//
//  HeapSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 7/24/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: HeapSort Algorithm

extension Heap {
    /**
         Sorts in O(n * log n).
         - Parameter desc: If you want the elements sorted in descending order... or not :)
         - Returns: Returns the elements of the sequence, sorted descreasingly - use a max-heap
     */
    @discardableResult
    public mutating func sort(desc: Bool = true) -> [Item] {
        var sorted: [Item] = []
        while let min = extract() {
            sorted.append(min)
        }
        return desc ? sorted : sorted.reversed()
    }
}

extension Sequence where Element: Hashable {
    /**
         Sorts in O(n * log n).
         - Returns: Returns the elements of the sequence, sorted.
     */
    public func heapSorted(by comparator: @escaping (Element, Element) -> Bool) -> [Element] {
        var heap = Heap(elements: self, comparaisonFunction: comparator)
        return heap.sort()
    }
}

extension Sequence where Element: Hashable, Element: Comparable {
    /**
         Sorts in O(n * log n).
         - Parameter desc: If you want the elements sorted in descending order... or not :)
         - Returns: Returns the elements of the sequence, sorted.
     */
    public func heapSorted(desc: Bool = true) -> [Element] {
        var heap = Heap(elements: self)
        return heap.sort(desc: desc)
    }
}
