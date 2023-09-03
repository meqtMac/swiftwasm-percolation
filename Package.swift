// swift-tools-version:5.8

import PackageDescription

let targetName = "Percolation"
let productName = targetName
let packageName = targetName

let package = Package(
    name: packageName,
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: productName,
            targets: [targetName]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftwasm/JavaScriptKit.git",
            .upToNextMajor(from: "0.15.0")),
//        .package(
//            url: "https://github.com/swiftwasm/WebAPIKit.git",
//            branch: "main"
//        )
    ],
    targets: [
        .executableTarget(
            name: productName,
            dependencies: [
                "JavaScriptKit"
            ]
        ),
    ]
)
