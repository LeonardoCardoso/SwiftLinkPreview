// swift-tools-version:5.0
//
//  Package.swift
//  SwiftLinkPreview
//
//  Created by Leonardo Cardoso on 04/07/2016.
//  Copyright © 2016 leocardz.com. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SwiftLinkPreview",
    platforms: [
        .iOS("8.0"),
        .macOS("10.11"),
        .tvOS("9.0"),
        .watchOS("2.0")
    ],
    products: [
        .library(
            name: "SwiftLinkPreview",
            targets: ["SwiftLinkPreview"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftLinkPreview",
            dependencies: [],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
