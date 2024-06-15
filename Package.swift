// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "SDK",
    platforms: [
        .iOS(.v13), .macOS(.v11)
    ],
    products: [
        .library(
            name: "SDK",
            targets: ["SDK", "DVPNSDK"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "SDK",
            dependencies: [
                .target(name: "DVPNSDK")
            ],
            path: "Sources"
        ),
        .binaryTarget(
            name: "DVPNSDK",
            path: "Frameworks/DVPNSDK.xcframework"
        )
    ]
)
