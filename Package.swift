// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "Yale",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "Yale",
      targets: ["Yale"]
    ),
    .executable(
      name: "YaleClient",
      targets: ["YaleClient"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    // Depend on the Swift 5.9 release of SwiftSyntax
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
  ],
  targets: [
    .macro(
      name: "YaleMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .target(
      name: "Yale",
      dependencies: [
        "YaleMacros",
        .product(name: "Logging", package: "swift-log"),
      ]
    ),
    .testTarget(
      name: "YaleTests",
      dependencies: [
        "Yale",
        "YaleMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ]
    ),
    .executableTarget(name: "YaleClient", dependencies: ["Yale"]),
  ]
)
