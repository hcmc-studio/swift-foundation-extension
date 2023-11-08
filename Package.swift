// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFoundationExtension",
    products: [
        .library(
            name: "SwiftFoundationExtension",
            targets: ["SwiftFoundationExtension"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.1.0")),
    ],
    targets: [
        .target(
            name: "SwiftFoundationExtension",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms")
            ]
        ),
    ]
)
