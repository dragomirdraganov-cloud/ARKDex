import Foundation

struct AppConfig {
    let baseURL: URL
    let appName: String

    static let current = AppConfig(
        baseURL: URL(string: "https://example.com") ?? URL(fileURLWithPath: "/"),
        appName: "SwiftUIMVVMTemplate"
    )
}
