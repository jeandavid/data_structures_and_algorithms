//
//  MergeSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: MergeSort

extension Array where Element: Comparable {
    /**
         Sorts in O(n * log n).
         - Returns: Returns the elements of the array, sorted.
     */
    public func mergeSorted() -> [Element] {
        guard self.count > 1 else {return self}
        let middle: Int = self.count / 2
        let left = Array(self[..<middle])
        let right = Array(self[middle...])
        return merge(left.mergeSorted(), right.mergeSorted())
    }
    
    /**
         Merge left and right into a sorted array
     
         - Precondition: Left and Right and sorted
         - Returns: Returns a sorted array that merges the two input arrays.
     */
    public func merge(_ left: [Element], _ right: [Element]) -> [Element] {
        var merged = [Element]()
        guard let firstLeft = left.first, let firstRight = right.first else {
            return merged + left + right
        }
        if firstLeft < firstRight {
            merged = [firstLeft] + merge(Array(left.dropFirst()), right)
        } else {
            merged = [firstRight] + merge(left, Array(right.dropFirst()))
        }
        return merged
    }
}
