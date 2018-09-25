//
//  LicenseType.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/18.
//

import Foundation

public protocol LicenseType {
    typealias Dictionary = [String: String]
    var type: String { get }
    var title: String { get }
    var fileName: String { get }
    var object: Dictionary { get }
}
