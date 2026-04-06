// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PicTanCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v13)
    ],
    products: [
        .library(name: "PicTanCore", targets: ["PicTanCore"])
    ],
    targets: [
        .target(name: "PicTanCore", path: "src"),
        .testTarget(name: "PicTanCoreTests", dependencies: ["PicTanCore"], path: "tests")
    ]
)
