// swift-tools-version:5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "ARSelectableView",
					  platforms: [.macOS(.v10_10),
								  .iOS(.v13),
								  .tvOS(.v9),
								  .watchOS(.v2)],
					  products: [.library(name: "ARSelectableView",
										  targets: ["ARSelectableView"])],
					  targets: [.target(name: "ARSelectableView",
										path: "ARSelectableView"),],
					  swiftLanguageVersions: [.v5])
