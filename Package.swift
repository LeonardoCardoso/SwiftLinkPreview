// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftLinkPreview",
    platforms: [
        .iOS(.v8),
    ],
    products: [
        .library(name: "SwiftLinkPreview", targets: ["SwiftLinkPreview"]),
    ],
    targets: [
        .target(name: "SwiftLinkPreview", path: "Sources")
    ]
)
