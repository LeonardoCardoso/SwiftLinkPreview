// swift-tools-version:4.2
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
    products: [
      .library(name: "SwiftLinkPreview",
               targets: ["SwiftLinkPreview"])
    ],
    targets: [
      .target(
        name: "SwiftLinkPreview",
        dependencies: [],
        path: "Sources")
    ]
)
