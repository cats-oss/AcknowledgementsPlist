//
//  ArrayExtension.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/20.
//

import Foundation

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return count == other.count && sorted() == other.sorted()
    }
}
