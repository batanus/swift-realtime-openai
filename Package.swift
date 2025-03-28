// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "OpenAIRealtime",
	platforms: [
		.iOS(.v15),
		.tvOS(.v15),
		.macOS(.v13),
		.watchOS(.v10),
		.visionOS(.v1),
		.macCatalyst(.v17),
	],
	products: [
		.library(name: "OpenAIRealtime", type: .static, targets: ["OpenAIRealtime"]),
	],
	dependencies: [
		.package(url: "https://github.com/stasel/WebRTC.git", branch: "latest"),
	],
	targets: [
		.target(name: "OpenAIRealtime", dependencies: ["WebRTC"], path: "./src"),
	]
)
