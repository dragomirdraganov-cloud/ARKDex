import Foundation
import OSLog

enum Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "SwiftUIMVVMTemplate"

    static let app = os.Logger(subsystem: subsystem, category: "App")
    static let networking = os.Logger(subsystem: subsystem, category: "Networking")
}
