//
//  ConstMocks.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/20.
//

import Foundation
@testable import AcknowledgementsPlistCore

enum ConstMocks {
    static let manualAcknowledgementsPath = "./Tests/AcknowledgementsPlistTests/Dummy/pcProject/ManualAcknowledgements.plist"

    static let pProjectPodsLicensePaths = [URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pProject/Pods/libA/LICENSE").path,
                                           URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pProject/Pods/libB/license.md").path]

    static let cProjectCarthageLicensePaths = [URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/cProject/Carthage/Checkouts/libC/license").path,
                                               URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/cProject/Carthage/Checkouts/libD/license.txt").path]

    static let pcProjectPodsLicensePaths = [URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pcProject/Pods/libA/LICENSE").path,
                                            URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pcProject/Pods/libB/license.md").path]

    static let pcProjectCarthageLicensePaths = [URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pcProject/Carthage/Checkouts/libC/license").path,
                                                URL(fileURLWithPath: "./Tests/AcknowledgementsPlistTests/Dummy/pcProject/Carthage/Checkouts/libD/license.txt").path]

    static let pProjectLicenses = [License(title: "libA", footerText: "AAA"),
                                   License(title: "libB", footerText: "BBB")]

    static let cProjectLicenses = [License(title: "libC", footerText: "CCC"),
                                   License(title: "libD", footerText: "DDD")]

    static let pcProjectLicenses = [License(title: "libA", footerText: "AAA"),
                                    License(title: "libB", footerText: "BBB"),
                                    License(title: "libC", footerText: "CCC"),
                                    License(title: "libD", footerText: "DDD")]

    static let pcProjectAddManualLicenses = [License(title: "libA", footerText: "AAA"),
                                             License(title: "libB", footerText: "BBB"),
                                             License(title: "libC", footerText: "CCC"),
                                             License(title: "libD", footerText: "DDD"),
                                             License(title: "libE", footerText: "EEE"),
                                             License(title: "libF", footerText: "FFF")]

    static let pProjectLicenseLinks = [LicenseLink(title: "libA"),
                                       LicenseLink(title: "libB")]

    static let cProjectLicenseLinks = [LicenseLink(title: "libC"),
                                       LicenseLink(title: "libD")]

    static let pcProjectLicenseLinks = [LicenseLink(title: "libA"),
                                        LicenseLink(title: "libB"),
                                        LicenseLink(title: "libC"),
                                        LicenseLink(title: "libD")]

    static let pcProjecttAddManualLicenseLinks = [LicenseLink(title: "libA"),
                                                  LicenseLink(title: "libB"),
                                                  LicenseLink(title: "libC"),
                                                  LicenseLink(title: "libD"),
                                                  LicenseLink(title: "libE"),
                                                  LicenseLink(title: "libF")]
}
