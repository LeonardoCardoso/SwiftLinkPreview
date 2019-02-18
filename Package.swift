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
    dependencies: [
        .Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 4, minor: 0)
        ]
)
