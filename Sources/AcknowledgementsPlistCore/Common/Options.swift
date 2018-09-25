//
//  Options.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation

public struct Options {
    public let projectRootPath: String

    public let outputPlistPath: String
    public let outputBundlePath: String

    public let podsPath: String
    public let carthageCheckoutsPath: String
    public let manualAcknowledgementsPath: String

    public init(projectRootPath: String,
                outputPlistPath: String,
                outputBundlePath: String,
                podsPath: String,
                carthageCheckoutsPath: String,
                manualAcknowledgementsPath: String) {
        self.projectRootPath = projectRootPath
        self.outputPlistPath = outputPlistPath
        self.outputBundlePath = outputBundlePath
        self.podsPath = podsPath
        self.carthageCheckoutsPath = carthageCheckoutsPath
        self.manualAcknowledgementsPath = manualAcknowledgementsPath
    }
}
