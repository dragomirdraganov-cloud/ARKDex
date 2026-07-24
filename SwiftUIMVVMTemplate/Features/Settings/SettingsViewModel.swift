import Observation

enum SettingsSaveState: Equatable, Sendable {
    case idle
    case saved
    case failed
}

@MainActor
@Observable
final class SettingsViewModel {
    var isAnalyticsEnabled = false
    private(set) var isLoading = false
    private(set) var isSaving = false
    private(set) var saveState: SettingsSaveState = .idle

    private let store: any KeyValueStore
    private var hasLoaded = false

    init(store: any KeyValueStore) {
        self.store = store
    }

    func load() async {
        guard !hasLoaded else { return }
        isLoading = true
        isAnalyticsEnabled = await store.bool(for: .analyticsEnabled) ?? false
        hasLoaded = true
        isLoading = false
    }

    func save() async {
        isSaving = true
        saveState = .idle

        do {
            try await store.set(isAnalyticsEnabled, for: .analyticsEnabled)
            saveState = .saved
        } catch {
            saveState = .failed
        }

        isSaving = false
    }
}

