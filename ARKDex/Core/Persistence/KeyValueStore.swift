import Foundation

enum KeyValueKey: String, Sendable {
    case analyticsEnabled = "settings.analyticsEnabled"
}

protocol KeyValueStore: Sendable {
    func bool(for key: KeyValueKey) async -> Bool?
    func set(_ value: Bool, for key: KeyValueKey) async throws
}

actor UserDefaultsKeyValueStore: KeyValueStore {
    private let defaults: UserDefaults

    init(suiteName: String? = nil) {
        if let suiteName, let suiteDefaults = UserDefaults(suiteName: suiteName) {
            defaults = suiteDefaults
        } else {
            defaults = .standard
        }
    }

    func bool(for key: KeyValueKey) -> Bool? {
        guard defaults.object(forKey: key.rawValue) != nil else { return nil }
        return defaults.bool(forKey: key.rawValue)
    }

    func set(_ value: Bool, for key: KeyValueKey) {
        defaults.set(value, forKey: key.rawValue)
    }
}

actor InMemoryKeyValueStore: KeyValueStore {
    private var values: [KeyValueKey: Bool]

    init(values: [KeyValueKey: Bool] = [:]) {
        self.values = values
    }

    func bool(for key: KeyValueKey) -> Bool? {
        values[key]
    }

    func set(_ value: Bool, for key: KeyValueKey) {
        values[key] = value
    }
}

