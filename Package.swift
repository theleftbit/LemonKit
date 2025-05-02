// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LemonKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "LemonKit",
            targets: ["LemonKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/theleftbit/BSWFoundation.git", from: "7.1.0"),
    ],
    targets: [
        .target(
            name: "LemonKit",
            dependencies: ["BSWFoundation"]
        ),
        .testTarget(
            name: "LemonKitTests",
            dependencies: ["LemonKit"]
        ),
    ]
)
