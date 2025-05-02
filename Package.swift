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
            type: .dynamic,
            targets: ["LemonKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/theleftbit/BSWFoundation.git", from: "7.1.0"),
        .package(url: "https://source.skip.tools/skip.git", from: "1.4.4"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "LemonKit",
            dependencies: [
                "BSWFoundation",
                .product(name: "SkipFuse", package: "skip-fuse")
            ],
            plugins: [
                .plugin(name: "skipstone", package: "skip")
            ]
        ),
        .testTarget(
            name: "LemonKitTests",
            dependencies: ["LemonKit"]
        ),
    ]
)
