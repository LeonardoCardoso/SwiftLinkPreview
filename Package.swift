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
    platforms: [.iOS(.v8)],
    products: [
      .library(name: "SwiftLinkPreview",
               targets: ["SwiftLinkPreview"])
    ]
)
