// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spark",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Spark",
            targets: ["Spark"]
        ),
        .library(
            name: "SparkDemo",
            targets: ["SparkDemo"]
        )
    ],
    dependencies: [
        // Git
//        .package(
//            url: "https://github.com/robergro/spm-poc-common.git",
//            from: "1.0.0"
//        ),
//        .package(
//            url: "https://github.com/robergro/spm-poc-theming.git",
//            from: "1.0.0"
//        ),
//        .package(
//            url: "https://github.com/robergro/spm-poc-component.git",
//            from: "1.0.0"
//        ),

        // Local
        .package(
            path: "../../spm-poc-common"
        ),
        .package(
            path: "../../spm-poc-theming"
        ),
        .package(
            path: "../../spm-poc-component"
        ),

        // External
        .package(
            url: "https://github.com/realm/SwiftLint",
            from: "0.54.0"
        )
    ],
    targets: [
        .target(
            name: "Spark",
            dependencies: [
                .product(
                    name: "SparkInternal",
                    package: "spm-poc-common"
                ),
                .product(
                    name: "SparkTheming",
                    package: "spm-poc-theming"
                ),
                .product(
                    name: "SparkTag",
                    package: "spm-poc-component"
                )
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "SparkDemo",
            dependencies: [
                "Spark",
                .product(
                    name: "SparkTheme",
                    package: "spm-poc-theming"
                ),
            ],
            resources: [
                .process("Resources/")
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintPlugin",
                    package: "SwiftLint"
                )
            ]
        )
    ]
)
