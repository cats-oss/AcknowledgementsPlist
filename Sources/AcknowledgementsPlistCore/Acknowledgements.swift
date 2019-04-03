//
//  Acknowledgements.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation

public final class Acknowledgements: LicenseURLsMakable, LicensesMakable, OutputMakable {

    public let options: Options
    public let manager: FileManager = .default
    public var podsLicenseURLs: [URL] = []
    public var carthageLicenseURLs: [URL] = []
    public var manualLicenseURLs: [URL] = []

    public init(options: Options) throws {
        self.options = options
    }

    public func make() throws {
        print("Start AcknowledgementsPlist..")
        manager.changeCurrentDirectoryPath(options.projectRootPath)
        try makeLicenseURLs()
        let isMakePlist = !options.outputPlistPath.isEmpty && options.outputBundlePath.isEmpty
        let isMakeBundle = options.outputPlistPath.isEmpty && !options.outputBundlePath.isEmpty
        if isMakePlist {
            try makePlist()
        } else if isMakeBundle {
            try makeBundle()
        }
    }

    private func makePlist() throws {
        let licenses = try makeLicenses()
        printAddLicense(licenses: licenses)
        try outputPlist(licenses: licenses)
    }

    private func makeBundle() throws {
        // MARK: make Acknowledgements.plist of LicenseLinks
        let licenseLinks = try makeLicenseLinks()
        printAddLicense(licenses: licenseLinks)
        try outputLinkPlist(licenseLinks: licenseLinks)

        // MARK: make each license plist in folder
        let licenses = try makeLicenses()
        printAddLicense(licenses: licenses)
        try outputEachPlist(licenses: licenses)
    }

    private func printAddLicense(licenses: [LicenseType]) {
        licenses.forEach {
            print("Add \($0.type) - " + $0.title)
        }
    }
}
