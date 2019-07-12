//
//  LicenseURLsGettable.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/18.
//

import Foundation

public protocol LicenseURLsMakable: class {
    var options: Options { get }
    var manager: FileManager { get }
    var podsLicenseURLs: [URL] { get set }
    var carthageLicenseURLs: [URL] { get set }
    var manualLicenseURLs: [URL] { get set }
}

extension LicenseURLsMakable {

    public func makeLicenseURLs() throws {
        podsLicenseURLs = try getPodsLicenseURLs()
        carthageLicenseURLs = try getCarthageLicenseURLs()
        manualLicenseURLs = try getManualLicenseURLs()

        if podsLicenseURLs.isEmpty && carthageLicenseURLs.isEmpty && manualLicenseURLs.isEmpty {
            throw AckError.emptyLicenseURLs
        }
    }

    private func getPodsLicenseURLs() throws -> [URL] {
        var podsDirURL: URL? = nil
        if options.podsPath.isEmpty {
            let allDirContentsURLs = try getAllDirContentsURLs()
            let podsDirURLs = allDirContentsURLs.filter { url in
                let isLastPathPodsStr = url.lastPathComponent == "Pods"
                let isContainOnePodsStr = url.path.numberOfOccurrences(of: "Pods") == 1
                let isNotContainCarthageStrComponents = !url.path.localizedCaseInsensitiveContains("carthage")
                return isLastPathPodsStr && isContainOnePodsStr && isNotContainCarthageStrComponents
            }
            podsDirURL = podsDirURLs.first
        } else {
            podsDirURL = URL(string: options.podsPath)
        }

        return try podsDirURL.map { url in
            let podsBinaryDirURL = url.appendingPathComponent("/_Prebuild", isDirectory: true)
            return try getLicenseURLs(dirURL: url) + getLicenseURLs(dirURL: podsBinaryDirURL)
            } ?? []
    }

    private func getCarthageLicenseURLs() throws -> [URL] {
        var carthageCheckoutsDirURL: URL? = nil
        if options.carthageCheckoutsPath.isEmpty {
            let allDirContentsURLs = try getAllDirContentsURLs()
            let carthageCheckoutsDirURLs = allDirContentsURLs.filter { url in
                let isLastPathCheckoutsStr = url.lastPathComponent == "Checkouts"
                let isContainOneCarthageStr = url.path.numberOfOccurrences(of: "Carthage") == 1
                let isContainOneCheckoutsStr = url.path.numberOfOccurrences(of: "Checkouts") == 1
                let isNotContainPodsStrComponents = !url.path.localizedCaseInsensitiveContains("pods")
                return isLastPathCheckoutsStr && isContainOneCarthageStr && isContainOneCheckoutsStr && isNotContainPodsStrComponents
            }
            carthageCheckoutsDirURL = carthageCheckoutsDirURLs.first
        } else {
            carthageCheckoutsDirURL = URL(string: options.carthageCheckoutsPath)
        }
        guard let url = carthageCheckoutsDirURL else { return [] }
        return try getLicenseURLs(dirURL: url)
    }

    private func getManualLicenseURLs() throws -> [URL] {
        let dirURLString = options.manualLicenseFilesPath.isEmpty ? nil : options.manualLicenseFilesPath
        let url = dirURLString.flatMap(URL.init)
        return try url.map(getLicenseURLs) ?? []
    }

    private func getAllDirContentsURLs() throws -> [URL] {
        let managerOptions: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles]
        guard let rootURL = URL(string: manager.currentDirectoryPath), let allDirPaths = manager.enumerator(at: rootURL, includingPropertiesForKeys: nil, options: managerOptions) else {
            throw AckError.projectRootPath
        }

        guard let allDirContentsURLs = allDirPaths.allObjects as? [URL] else {
            throw AckError.convertedURL
        }
        return allDirContentsURLs
    }

    private func getLicenseURLs(dirURL: URL) throws -> [URL] {
        let managerOptions: FileManager.DirectoryEnumerationOptions = [.skipsSubdirectoryDescendants, .skipsHiddenFiles]
        let libDirURLs = try manager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil, options: managerOptions)
        let libDirUnderURLs = Array(libDirURLs.compactMap { try? manager.contentsOfDirectory(at: $0, includingPropertiesForKeys: nil, options: managerOptions) }.joined())

        var licenseURLs = libDirUnderURLs.filter { url in
            let lastPathComp = url.lastPathComponent
            return lastPathComp.localizedCaseInsensitiveContains("license") || lastPathComp.localizedCaseInsensitiveContains("licence")
        }

        if !options.excludeWordArray.isEmpty {
            options.excludeWordArray.forEach { exStr in
                licenseURLs = licenseURLs.compactMap { !$0.path.localizedCaseInsensitiveContains(exStr) ? $0 : nil }
            }
        }

        return licenseURLs
    }
}
