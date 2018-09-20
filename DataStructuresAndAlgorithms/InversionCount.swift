//
//  InversionCount.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

// MARK: InversionCount

extension Array where Element: Comparable {
    /**
        Number of paired inversion in the array. Runs in O(n * log n).
     */
    public var inversionCount: Int {
        return sortAndCountInversion(self).count
    }
    
    /**
        Returns the sorted array and the number of inversion as a tuple.
     */
    private func sortAndCountInversion(_ elements: [Element]) -> (sorted: [Element], count: Int) {
        guard elements.count > 1 else {return (sorted: elements, count: 0)}
        let middle: Int = elements.count / 2
        let (left, countLeft) = sortAndCountInversion(Array(elements[..<middle]))
        let (right, countRight) = sortAndCountInversion(Array(elements[middle...]))
        let (sorted, countSplit) = mergeAndCountSplitInversion(left, right)
        return (sorted, countLeft + countRight + countSplit)
    }
    
    /**
         Merge left and right into a sorted array
         
         - Precondition: Left and Right and sorted
         - Returns: Returns a sorted array that merges the two input arrays.
     */
    private func mergeAndCountSplitInversion(_ left: [Element], _ right: [Element]) -> (sorted: [Element], count: Int) {
        var merged = [Element]()
        var splitInversion = 0
        var leftIndex = 0
        var rightIndex = 0
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                merged.append(left[leftIndex])
                leftIndex += 1
            } else {
                merged.append(right[rightIndex])
                rightIndex += 1
                splitInversion += left.count - leftIndex
            }
        }
        while leftIndex < left.count {
            merged.append(left[leftIndex])
            leftIndex += 1
        }
        while rightIndex < right.count {
            merged.append(right[rightIndex])
            rightIndex += 1
        }
        return (merged, splitInversion)
    }
}

