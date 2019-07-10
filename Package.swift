// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "AcknowledgementsPlist",
    products: [
        .executable(name: "acknowledgementsplist", targets: ["acknowledgementsplist"])
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "acknowledgementsplist",
            dependencies: ["Commander", "AcknowledgementsPlistCore"]
        ),
        .target(
            name: "AcknowledgementsPlistCore",
            dependencies: []
        ),
        .testTarget(
            name: "AcknowledgementsPlistTests",
            dependencies: ["acknowledgementsplist"]
        ),
    ]
)
