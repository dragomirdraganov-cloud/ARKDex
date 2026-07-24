import Testing
@testable import SwiftUIMVVMTemplate

struct KeyValueStoreTests {
    @Test
    func storesAndReadsBoolean() async throws {
        let store = InMemoryKeyValueStore()

        #expect(await store.bool(for: .analyticsEnabled) == nil)

        await store.set(true, for: .analyticsEnabled)

        #expect(await store.bool(for: .analyticsEnabled) == true)
    }
}
