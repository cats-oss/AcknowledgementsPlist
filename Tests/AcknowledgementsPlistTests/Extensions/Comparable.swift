//
//  Comparable.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/21.
//

import Foundation
@testable import AcknowledgementsPlistCore

extension License: Comparable {
    public static func < (lhs: License, rhs: License) -> Bool {
        return lhs.title < lhs.title
    }

    public static func == (lhs: License, rhs: License) -> Bool {
        return lhs.title == lhs.title
    }
}

extension LicenseLink: Comparable {
    public static func < (lhs: LicenseLink, rhs: LicenseLink) -> Bool {
        return lhs.title < lhs.title
    }

    public static func == (lhs: LicenseLink, rhs: LicenseLink) -> Bool {
        return lhs.title == lhs.title
    }
}
