//
//  LicenseLink.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation

public struct LicenseLink: LicenseType, Hashable {

    private enum Name {
        static let plist = "AcknowledgementLinks.plist"
        static let folder = "Licenses"
    }

    private enum Key {
        static let file = "File"
        static let title = "Title"
        static let type = "Type"
    }

    private enum Value {
        static let type = "PSChildPaneSpecifier"
    }

    public let title: String

    public var type: String {
        return String(describing: Swift.type(of: self))
    }

    public var fileName: String {
        return Name.plist
    }

    public var object: LicenseType.Dictionary {
        return [Key.file: "\(Name.folder)/\(title)",
                Key.title: title,
                Key.type: Value.type]
    }

    public init(object: LicenseType.Dictionary) {
        title = object[Key.title] ?? "Unknown"
    }

    public init(title: String) {
        self.title = title
    }

    public static func getPlistPath(outputBundlePath: String) -> String {
        return "\(outputBundlePath)/\(Name.plist)"
    }

    public static func getFolderPath(outputBundlePath: String) -> String {
        return "\(outputBundlePath)/\(Name.folder)"
    }
}
