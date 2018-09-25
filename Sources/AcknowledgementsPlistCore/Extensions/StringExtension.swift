//
//  StringExtension.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation

extension String {
    func numberOfOccurrences(of word: String) -> Int {
        var count = 0
        var nextRange = startIndex..<endIndex
        while let range = range(of: word, options: .caseInsensitive, range: nextRange) {
            count += 1
            nextRange = range.upperBound..<endIndex
        }
        return count
    }
}
