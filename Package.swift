// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AcknowledgementsPlist",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git",
                 from: "0.8.0")
    ],
    targets: [
        .target(
            name: "AcknowledgementsPlist",
            dependencies: ["Commander", "AcknowledgementsPlistCore"]),
        .target(
            name: "AcknowledgementsPlistCore",
            dependencies: []),
        .testTarget(
            name: "AcknowledgementsPlistTests",
            dependencies: ["AcknowledgementsPlist"]),
    ]
)
