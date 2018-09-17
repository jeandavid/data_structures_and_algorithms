//
//  BinarySearch.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 7/27/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: BinarySearch

// The RandomAccessCollection protocol guarantees constant time:
// * access to any elements.
// * distance measurement between two elements.

extension RandomAccessCollection where Element: Comparable {
    /**
         Runs in O(log n).
     
         - Precondition: Collection should be sorted.
         - Returns: The index of the key if found, nil otherwise
     */
    public func binarySearch(for key: Element) -> Index? {
        return binarySearch(for: key, in: self.prefix(self.count))
    }
    
    /**
         Recursive implementation.
         Uses a sub sequence to reduce memory usage.
     */
    private func binarySearch(for key: Element, in slice: Self.SubSequence) -> Index? {
        guard slice.count > 1 else {
            return key == slice.first! ? slice.startIndex : nil
        }
        // As a sub sequence, the slice keeps the same indexing as its base collection
        let middle: Index = index(slice.startIndex, offsetBy: distance(from: slice.startIndex, to: slice.endIndex) / 2)
        return key < slice[middle]
            ? binarySearch(for: key, in: slice[..<middle])
            : binarySearch(for: key, in: slice[middle...])
    }
}
