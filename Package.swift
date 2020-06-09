// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColourPickerMaker",
    platforms: [.iOS(.v13), .macOS(.v10_15)], products: [
      .library(
        name: "ColourPickerMaker",
        targets: ["ColourPickerMaker"]),
  ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ColourPickerMaker",
            dependencies: []),
        .testTarget(
            name: "ColourPickerMakerTests",
            dependencies: ["ColourPickerMaker"]),
    ]
)
