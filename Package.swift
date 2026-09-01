// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "APSSPMediationAppLovin",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "APSSPMediationAppLovin", targets: ["APSSPMediationAppLovin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IGAWorksDev/ap-APSSPSDK-SPM.git", from: "3.4.0"),
        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git", exact: "13.6.3"),
    ],
    targets: [
        .target(name: "APSSPMediationAppLovin",
                dependencies: [
                    .product(name: "APSSPSDK", package: "ap-APSSPSDK-SPM"),
                    .product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package"),
                ],
                path: "Sources/MediationAppLovin"),
    ]
)
