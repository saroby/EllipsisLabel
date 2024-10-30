// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EllipsisLabel",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "EllipsisLabel", targets: ["EllipsisLabel"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EllipsisLabel",
            dependencies: []
        ),
    ],
    swiftLanguageVersions: [.v5]
)
