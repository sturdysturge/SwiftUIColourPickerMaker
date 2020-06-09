import PackageDescription

let package = Package(
    name: "ColourPickerMaker",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
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
