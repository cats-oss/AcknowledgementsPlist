//
//  main.swift
//  AcknowledgementsPlist
//
//  Created by Takuma Horiuchi on 2018/09/17.
//

import Foundation
import Commander
import AcknowledgementsPlistCore

let main = command(Argument<String>("project-root-path", description: "Project root path seen from the execution location."),
                   Argument<String>("output-path", description: "Absolute path of plist or bundle output path from project root."),
                   Option("pods-path", default: "", description: "Absolute path of pods from project root."),
                   Option("carthage-checkouts-path", default: "", description: "Absolute path of carthage from project root."),
                   Option("manual-plist-path", default: "", description: "Absolute path of carthage from project root.")
) { projectRootPath, outputPath, podsPath, carthageCheckoutsPath, manualAcknowledgementsPath in
    let outputPlistPath = outputPath.hasSuffix(".plist") ? outputPath : ""
    let outputBundlePath = outputPath.hasSuffix(".bundle") ? outputPath : ""
    let options = Options(projectRootPath: projectRootPath,
                          outputPlistPath: outputPlistPath,
                          outputBundlePath: outputBundlePath,
                          podsPath: podsPath,
                          carthageCheckoutsPath: carthageCheckoutsPath,
                          manualAcknowledgementsPath: manualAcknowledgementsPath)
    do {
        let acknowledgements = try Acknowledgements(options: options)
        try acknowledgements.make()
    } catch let error as AckError {
        switch error {
        case .projectRootPath:
            print("projectRootPath not found.")
        case .convertedURL:
            print("It could not be converted to URL.")
        case .podsDirURL:
            print("Pods directory URL not found.")
        case .carthageDirURL:
            print("Carthage directory URL not found.")
        case .podsCarhageLicenseURLs:
            print("Pods and Carthage URLs is impty.")
        case .manualAckPlist:
            print("ManualAcknowledgements.plist not found.")
        case .manualACKPref:
            print("PreferenceSpecifiers of ManualAcknowledgements.plist not found.")
        }
    } catch let error {
        print(error.localizedDescription)
    }
}

main.run()
