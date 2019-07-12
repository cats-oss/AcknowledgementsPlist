//
//  LicensesGettable.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/18.
//

import Foundation

public protocol LicensesMakable: class {
    var options: Options { get }
    var podsLicenseURLs: [URL] { get }
    var carthageLicenseURLs: [URL] { get }
    var manualLicenseURLs: [URL] { get }
}

extension LicensesMakable {

    private var libNamePathDiffFromLicenseCount: Int {
        return 2
    }

    public func makeLicenses() throws -> [LicenseType] {
        let podsLicenses = try getLicenses(licenseURLs: podsLicenseURLs)
        let carthageLicenses = try getLicenses(licenseURLs: carthageLicenseURLs)
        let manualPlistLicenses = try getManualPlistLicenses().map { License(object: $0) }
        let manualLicenses = try getLicenses(licenseURLs: manualLicenseURLs)
        return Set(podsLicenses + carthageLicenses + manualPlistLicenses + manualLicenses)
            .sorted(by: { $0.title < $1.title })
    }

    public func makeLicenseLinks() throws -> [LicenseType] {
        let podsLicenseLinks = getLicenseLinks(licenseURLs: podsLicenseURLs)
        let carthageLicenseLinks = getLicenseLinks(licenseURLs: carthageLicenseURLs)
        let manualLicenseLinks = try getManualPlistLicenses().map { LicenseLink(object: $0) }
        return Set(podsLicenseLinks + carthageLicenseLinks + manualLicenseLinks)
            .sorted(by: { $0.title < $1.title })
    }

    private func getLicenses(licenseURLs: [URL]) throws -> [License] {
        return try licenseURLs.map { url in
            let pathComponents = url.pathComponents
            let libNameIndex = pathComponents.count - libNamePathDiffFromLicenseCount
            let libName = pathComponents[libNameIndex]
            let legalText = try String(contentsOf: url, encoding: .utf8)
            return License(title: libName, footerText: legalText)
        }
    }

    private func getLicenseLinks(licenseURLs: [URL]) -> [LicenseLink] {
        return licenseURLs.map { url in
            let pathComponents = url.pathComponents
            let libNameIndex = pathComponents.count - libNamePathDiffFromLicenseCount
            let libName = pathComponents[libNameIndex]
            return LicenseLink(title: libName)
        }
    }

    private func getManualPlistLicenses() throws -> [LicenseType.Dictionary] {
        if options.manualPlistPath.isEmpty {
            return []

        } else {
            guard let plist = NSDictionary(contentsOfFile: options.manualPlistPath) else {
                throw AckError.manualAckPlist
            }

            guard let object = plist.object(forKey: "PreferenceSpecifiers") as? [LicenseType.Dictionary] else {
                throw AckError.manualACKPref
            }

            return object
        }
    }
}
