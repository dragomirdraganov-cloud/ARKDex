import Testing
@testable import SwiftUIMVVMTemplate

@MainActor
struct AppRouterTests {
    @Test
    func navigatesBackAndResetsPerTab() {
        let router = AppRouter()

        router.navigate(to: .detail(itemID: "home"), in: .home)
        router.navigate(to: .detail(itemID: "settings"), in: .settings)

        #expect(router.homePath == [.detail(itemID: "home")])
        #expect(router.settingsPath == [.detail(itemID: "settings")])

        router.goBack(in: .home)
        #expect(router.homePath.isEmpty)
        #expect(router.settingsPath.count == 1)

        router.resetAll()
        #expect(router.homePath.isEmpty)
        #expect(router.settingsPath.isEmpty)
    }
}

