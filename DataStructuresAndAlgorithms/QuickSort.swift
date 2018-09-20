//
//  QuickSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

// MARK: QuickSort

extension MutableCollection where Element: Comparable {
    /**
         Average running time of O(n * log n). Sorts in place.
         The elements of the collection are swapped, this is why we need the collection to be mutable.
     */
    public mutating func quickSort() {
        quickSort(from: startIndex, to: endIndex)
    }
    
    // The best running time case happens when the partition moves the pivot to the middle, i.e the pivot turns out to be the median.
    // In that case, we have a MergeSort type of recursion with a worst case running time of O(n * log n).
    // Each of the first three steps runs in linear time for types conforming to MutableCollection.
    private mutating func quickSort(from start: Index, to end: Index) {
        guard distance(from: start, to: end) > 1 else {return}
        let pivotIndex: Index = randomPivotIndex(between: start, and: end)
        let pivotIndexAfterPartition: Index = partitionAroundPivot(from: start, to: end, around: pivotIndex)
        quickSort(from: start, to: pivotIndexAfterPartition)
        quickSort(from: index(after: pivotIndexAfterPartition), to: end)
    }
    
    /**
        Runs in linear time.
     */
    private func randomPivotIndex(between start: Index, and end: Index) -> Index {
        let randomIndexOffset = arc4random_uniform(UInt32(distance(from: start, to: end)))
        return index(start, offsetBy: Int(randomIndexOffset))
    }
    
    /**
         Partitions the slice around the pivot in linear time.
         - Returns: The pivot's new index
     */
    public mutating func partitionAroundPivot(from start: Index, to end: Index, around pivotIndex: Index) -> Index {
        let pivot = self[pivotIndex]
        swapAt(start, pivotIndex)
        var finalPivotIndex = start
        var partitionedIndex = index(after: start)
        var unpartitionedIndex = index(after: start)
        for element in self[index(after: start)..<end] {
            // Make sure the element should be swapped
            guard element <= pivot else {
                // element is smaller than pivot, no swap, just advancing unpartitionedIndex
                unpartitionedIndex = index(after: unpartitionedIndex)
                continue
            }
            swapAt(unpartitionedIndex, partitionedIndex)
            finalPivotIndex = partitionedIndex
            partitionedIndex = index(after: partitionedIndex)
            unpartitionedIndex = index(after: unpartitionedIndex)
        }
        swapAt(start, finalPivotIndex)
        return finalPivotIndex
    }
}
