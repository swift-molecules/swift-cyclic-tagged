// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-cyclic-tagged",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Cyclic Tagged",
            targets: ["Cyclic Tagged"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-cyclic.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Cyclic Tagged",
            dependencies: [
                .product(name: "Cyclic", package: "swift-cyclic"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ]
        ),
        .testTarget(
            name: "Cyclic Tagged Tests",
            dependencies: [
                "Cyclic Tagged",
                .product(name: "Cyclic", package: "swift-cyclic"),
                .product(
                    name: "Cyclic Standard Library Integration",
                    package: "swift-cyclic"
                ),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
