// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Percolation",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "Percolation",
            targets: ["Percolation"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftwasm/JavaScriptKit.git",
            from: "0.15.0"
        ),
    ],
    targets: [
        .executableTarget(
            name: "Percolation",
            dependencies: [
                "JavaScriptKit"
            ]
        ),
    ]
)
