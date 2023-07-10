// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Eitri",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Eitri",
            targets: ["Eitri", "EitriDependencies"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/hyperoslo/Cache.git", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "EitriDependencies",
            dependencies: ["Cache"]),

        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "Eitri", 
            path: "Eitri.xcframework"
        )
    ]
)
