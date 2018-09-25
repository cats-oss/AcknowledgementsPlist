//
//  OutputMakable.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/19.
//

import Foundation

public protocol OutputMakable: class {
    var options: Options { get }
    var manager: FileManager { get }
}

extension OutputMakable {

    public func outputPlist(licenses: [LicenseType]) throws {
        let licensesData = try getPreferenceSpecifiersData(licenses: licenses)
        let outPutPath = options.outputPlistPath.isEmpty ? options.projectRootPath : options.outputPlistPath
        let outputPlistURL = URL(fileURLWithPath: outPutPath)
        manager.createFile(atPath: outputPlistURL.path, contents: nil)
        try licensesData.write(to: outputPlistURL)
    }

    public func outputLinkPlist(licenseLinks: [LicenseType]) throws {
        let licenseLinksData = try getPreferenceSpecifiersData(licenses: licenseLinks)
        let outputBundlePlistURL = URL(fileURLWithPath: LicenseLink.getPlistPath(outputBundlePath: options.outputBundlePath))
        manager.createFile(atPath: outputBundlePlistURL.path, contents: nil)
        try licenseLinksData.write(to: outputBundlePlistURL)
    }

    public func outputEachPlist(licenses: [LicenseType]) throws {
        let outputFolderURL = URL(fileURLWithPath: LicenseLink.getFolderPath(outputBundlePath: options.outputBundlePath))
        try manager.createDirectory(at: outputFolderURL, withIntermediateDirectories: true, attributes: nil)
        try licenses.forEach {
            let plistURL = outputFolderURL.appendingPathComponent($0.fileName)
            manager.createFile(atPath: plistURL.path, contents: nil)
            let licensesData = try getPreferenceSpecifiersData(licenses: [$0])
            try licensesData.write(to: plistURL)
        }
    }

    private func getPreferenceSpecifiersData(licenses: [LicenseType]) throws -> Data {
        return try PropertyListSerialization.data(fromPropertyList: ["PreferenceSpecifiers": licenses.map { $0.object }], format: .xml, options: 0)
    }
}
