import Foundation
import OSLog

enum AppLog {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.dragomirdraganov.arkdex"

    static let app = Logger(subsystem: subsystem, category: "App")
    static let networking = Logger(subsystem: subsystem, category: "Networking")
    static let persistence = Logger(subsystem: subsystem, category: "Persistence")
}
