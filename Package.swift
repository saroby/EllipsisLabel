// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EllipsisLabel",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "EllipsisLabel", targets: ["EllipsisLabel"]),
    ],
    dependencies: [
        .package(url: "https://github.com/saroby/CocoaChain", branch: "main"),
    ],
    targets: [
        .target(
            name: "EllipsisLabel",
            dependencies: ["CocoaChain"],
            cSettings: [.define("FLEXLAYOUT_SWIFT_PACKAGE")]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
