//
//  License.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation

public struct License: LicenseType {

    private enum Key {
        static let title = "Title"
        static let footerText = "FooterText"
        static let type = "Type"
    }

    private enum Value {
        static let type = "PSGroupSpecifier"
    }

    public let title: String
    public let footerText: String

    public var type: String {
        return String(describing: Swift.type(of: self))
    }

    public var fileName: String {
        return title + ".plist"
    }

    public var object: LicenseType.Dictionary {
        return [Key.title: title,
                Key.footerText: footerText,
                Key.type: Value.type]
    }

    public init(object: LicenseType.Dictionary) {
        title = object[Key.title] ?? "Unknown"
        footerText = object[Key.footerText] ?? ""
    }

    public init(title: String, footerText: String) {
        self.title = title
        self.footerText = footerText
    }
}
