// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BSMultiTool",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BSMultiTool",
            targets: ["BSMultiTool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "BSMultiTool",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "Sources",
            sources: [
                "BSMultiTool",
                "Extensions"
            ]
        )
    ]
)

