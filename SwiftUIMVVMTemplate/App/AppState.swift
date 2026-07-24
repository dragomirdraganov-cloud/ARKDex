import Observation

@MainActor
@Observable
final class AppState {
    var selectedTab: AppTab = .home
}

enum AppTab: Hashable, Sendable {
    case home
    case settings
}

