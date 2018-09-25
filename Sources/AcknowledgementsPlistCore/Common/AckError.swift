//
//  AckError.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/20.
//

import Foundation

public enum AckError: Error {
    case projectRootPath
    case convertedURL
    case podsDirURL
    case carthageDirURL
    case podsCarhageLicenseURLs
    case manualAckPlist
    case manualACKPref
}
