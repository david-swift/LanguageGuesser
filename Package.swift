//  swift-tools-version: 5.9
//
//  Package.swift
//  LanguageGuesser
//
//  Created by david-swift on 06.07.2023.
//

import PackageDescription

/// The LanguageGuesser package.
let package = Package(
    name: "LanguageGuesser",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/david-swift/Countries", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.2.6")
    ],
    targets: [
        .executableTarget(
            name: "LanguageGuesser",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Countries", package: "Countries")
            ],
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        )
    ]
)
