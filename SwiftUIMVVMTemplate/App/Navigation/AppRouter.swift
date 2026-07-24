import Observation

@MainActor
@Observable
final class AppRouter {
    var homePath: [AppRoute] = []
    var settingsPath: [AppRoute] = []

    func navigate(to route: AppRoute, in tab: AppTab) {
        switch tab {
        case .home:
            homePath.append(route)
        case .settings:
            settingsPath.append(route)
        }
    }

    func goBack(in tab: AppTab) {
        switch tab {
        case .home:
            _ = homePath.popLast()
        case .settings:
            _ = settingsPath.popLast()
        }
    }

    func reset(tab: AppTab) {
        switch tab {
        case .home:
            homePath.removeAll()
        case .settings:
            settingsPath.removeAll()
        }
    }

    func resetAll() {
        homePath.removeAll()
        settingsPath.removeAll()
    }
}

