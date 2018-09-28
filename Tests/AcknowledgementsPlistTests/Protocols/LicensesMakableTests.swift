//
//  LicensesMakableTests.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/20.
//

import Foundation
import XCTest
@testable import AcknowledgementsPlistCore

class LicensesMakableTests: XCTestCase, LicensesMakable {

    var options: Options = .init(projectRootPath: "",
                                 outputPlistPath: "",
                                 outputBundlePath: "",
                                 podsPath: "",
                                 carthageCheckoutsPath: "",
                                 manualAcknowledgementsPath: "",
                                 excludeWordArray: [])
    var podsLicenseURLs: [URL] = []
    var carthageLicenseURLs: [URL] = []

    func testNotAllLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = []
        carthageLicenseURLs = []
        XCTAssertNoThrow(try makeLicenses())
        XCTAssertTrue(try makeLicenses().isEmpty)
    }

    func testPodsLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenses() as? [License] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenses())
        XCTAssertEqual(licenses, ConstMocks.pProjectLicenses)
    }

    func testCarthageLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenses() as? [License] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenses())
        XCTAssertEqual(licenses, ConstMocks.cProjectLicenses)
    }

    func testPodsCarthageLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenses() as? [License] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenses())
        XCTAssertEqual(licenses, ConstMocks.pcProjectLicenses)
    }

    func testPodsCarthageManualLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: ConstMocks.manualAcknowledgementsPath,
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenses() as? [License] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenses())
        XCTAssertEqual(licenses, ConstMocks.pcProjectAddManualLicenses)
    }

    func testPodsCarthageMissManualLicenses() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "foo",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        XCTAssertThrowsError(try makeLicenses())
    }

    func testNotAllLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = []
        carthageLicenseURLs = []
        XCTAssertNoThrow(try makeLicenseLinks())
        XCTAssertTrue(try makeLicenseLinks().isEmpty)
    }

    func testPodsLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenseLinks = try? makeLicenseLinks() as? [LicenseLink] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenseLinks())
        XCTAssertEqual(licenseLinks, ConstMocks.pProjectLicenseLinks)
    }

    func testCarthageLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenseLinks() as? [LicenseLink] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenseLinks())
        XCTAssertEqual(licenses, ConstMocks.cProjectLicenseLinks)
    }

    func testPodsCarthageLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenseLinks() as? [LicenseLink] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenseLinks())
        XCTAssertEqual(licenses, ConstMocks.pcProjectLicenseLinks)
    }

    func testPodsCarthageManualLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: ConstMocks.manualAcknowledgementsPath,
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        guard let licenses = try? makeLicenseLinks() as? [LicenseLink] else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try makeLicenseLinks())
        XCTAssertEqual(licenses, ConstMocks.pcProjecttAddManualLicenseLinks)
    }

    func testPodsCarthageMissManualLicenseLinks() {
        options = .init(projectRootPath: "",
                        outputPlistPath: "",
                        outputBundlePath: "",
                        podsPath: "",
                        carthageCheckoutsPath: "",
                        manualAcknowledgementsPath: "bar",
                        excludeWordArray: [])
        podsLicenseURLs = ConstMocks.pProjectPodsLicensePaths.map { URL(fileURLWithPath: $0) }
        carthageLicenseURLs = ConstMocks.pcProjectCarthageLicensePaths.map { URL(fileURLWithPath: $0) }
        XCTAssertThrowsError(try makeLicenseLinks())
    }
}
