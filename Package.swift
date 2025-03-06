// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rudder-CustomerIO",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "Rudder-CustomerIO",
            targets: ["Rudder-CustomerIO"]),
    ],
    dependencies: [
        .package(name: "Customer.io", url: "https://github.com/customerio/customerio-ios", .exact("3.8.0")),
        .package(name: "Rudder", url: "https://github.com/rudderlabs/rudder-sdk-ios", "1.29.0"..<"2.0.0")
    ],
    targets: [
        .target(
            name: "Rudder-CustomerIO",
            dependencies: [
                .product(name: "DataPipelines", package: "Customer.io"),
                .product(name: "Rudder", package: "Rudder"),
            ],
            path: "Rudder-CustomerIO",
            sources: ["Classes/"],
            publicHeadersPath: "Classes/",
            cSettings: [
                .headerSearchPath("Classes/")
            ]
        )
    ]
)
