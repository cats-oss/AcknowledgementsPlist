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
}

extension LicenseURLsMakable {

    public func makeLicenseURLs() throws {
        podsLicenseURLs = try getPodsLicenseURLs()
        carthageLicenseURLs = try getCarthageLicenseURLs()
        if podsLicenseURLs.isEmpty && carthageLicenseURLs.isEmpty {
            throw AckError.podsCarhageLicenseURLs
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
            if podsDirURLs.count != 1 { throw AckError.podsDirURL }
            podsDirURL = podsDirURLs.first
        } else {
            podsDirURL = URL(string: options.podsPath)
        }
        guard let url = podsDirURL else { return [] }
        return try getLicenseURLs(dirURL: url)
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
            if carthageCheckoutsDirURLs.count != 1 { throw AckError.carthageDirURL }
            carthageCheckoutsDirURL = carthageCheckoutsDirURLs.first
        } else {
            carthageCheckoutsDirURL = URL(string: options.carthageCheckoutsPath)
        }
        guard let url = carthageCheckoutsDirURL else { return [] }
        return try getLicenseURLs(dirURL: url)
    }

    private func getAllDirContentsURLs() throws -> [URL] {
        let options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles]
        guard let rootURL = URL(string: manager.currentDirectoryPath), let allDirPaths = manager.enumerator(at: rootURL, includingPropertiesForKeys: nil, options: options) else {
            throw AckError.projectRootPath
        }

        guard let allDirContentsURLs = allDirPaths.allObjects as? [URL] else {
            throw AckError.convertedURL
        }
        return allDirContentsURLs
    }

    private func getLicenseURLs(dirURL: URL) throws -> [URL] {
        let options: FileManager.DirectoryEnumerationOptions = [.skipsSubdirectoryDescendants, .skipsHiddenFiles]
        var libDirUnderURLs = [URL]()
        let libDirURLs = try manager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil, options: options)
        libDirURLs.forEach {
            if let libDirUnderURL = try? manager.contentsOfDirectory(at: $0, includingPropertiesForKeys: nil, options: options) {
                libDirUnderURLs.append(contentsOf: libDirUnderURL)
            }
        }

        let licenseURLs = libDirUnderURLs.filter { url in
            let lastPathComp = url.lastPathComponent
            return lastPathComp.localizedCaseInsensitiveContains("license") || lastPathComp.localizedCaseInsensitiveContains("licence")
        }
        return licenseURLs
    }
}
