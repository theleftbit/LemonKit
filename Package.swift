// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let zero = ProcessInfo.processInfo.environment["SKIP_ZERO"] != nil

var packageDependencies: [Package.Dependency] = [
    .package(url: "https://github.com/theleftbit/BSWFoundation.git", from: "7.1.0"),
]

if !zero {
    packageDependencies.append(contentsOf: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.5.11"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.2"),
    ])
}

var targetDependencies: [Target.Dependency] = [
    "BSWFoundation",
]

if !zero {
    targetDependencies.append(contentsOf: [
        .product(name: "SkipFuse", package: "skip-fuse")
    ])
}

var plugins: [Target.PluginUsage] = []
if !zero {
    plugins.append(contentsOf: [
        .plugin(name: "skipstone", package: "skip")
    ])
}

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
        .library(
            name: "LemonStaticKit",
            targets: ["LemonKit"]
        ),
    ],
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "LemonKit",
            dependencies: targetDependencies,
            plugins: plugins
        ),
        .testTarget(
            name: "LemonKitTests",
            dependencies: ["LemonKit"]
        ),
    ]
)
