//
//  RandomizedSelection.swift
//  DataStructuresAndAlgorithms
//
//  Created by Jean-David Morgenstern-Peirolo on 9/6/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

// MARK: Randomized Selection

extension Array where Element: Comparable {
    /**
         Randomized Selection returns the i-th order statistic, i.e the i-th smallest element.
         Runs in O(n log n).
     
         - Returns: The i-th order statistic
     */
    public mutating func randomizedSelection(of orderStatistic: Int) -> Element? {
        guard self.count > 1 else {return self.first}
        let pivotIndex: Int = Int(arc4random_uniform(UInt32(self.count)))
        let pivotIndexAfterPartition: Int = partitionAroundPivot(from: self.startIndex, to: self.endIndex, around: pivotIndex)
        guard pivotIndexAfterPartition != orderStatistic else {return self[orderStatistic]}
        if pivotIndexAfterPartition > orderStatistic {
            var subarray = Array(self[..<pivotIndexAfterPartition])
            return subarray.randomizedSelection(of: orderStatistic)
        } else {
            let newOrderStatistic = orderStatistic - pivotIndexAfterPartition
            var subarray = Array(self[pivotIndexAfterPartition...])
            return subarray.randomizedSelection(of: newOrderStatistic)
        }
    }
}

