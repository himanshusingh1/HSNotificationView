// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HSNotificationView",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "HSNotificationView",
            targets: ["HSNotificationView"]
        ),
    ],
    targets: [
        .target(
            name: "HSNotificationView",
            path: "HSNotificationView/Classes",
            resources: [
                .process("HSNotificationView.xib")
            ]
        ),
    ]
)
