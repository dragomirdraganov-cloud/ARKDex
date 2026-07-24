import Testing
@testable import SwiftUIMVVMTemplate

@MainActor
struct SettingsViewModelTests {
    @Test
    func loadsAndSavesPreference() async throws {
        let store = InMemoryKeyValueStore(values: [.analyticsEnabled: true])
        let viewModel = SettingsViewModel(store: store)

        await viewModel.load()
        #expect(viewModel.isAnalyticsEnabled)

        viewModel.isAnalyticsEnabled = false
        await viewModel.save()

        #expect(viewModel.saveState == .saved)
        #expect(await store.bool(for: .analyticsEnabled) == false)
    }
}

