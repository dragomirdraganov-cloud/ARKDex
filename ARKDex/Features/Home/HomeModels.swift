import Foundation

struct HomeSearchState: Equatable, Sendable {
    var query: String = ""

    var showsSuggestions: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

struct HomeContent: Equatable, Identifiable, Sendable {
    let id: String
    let title: String
    let message: String

    static let preview = HomeContent(
        id: "arkdex-home",
        title: "ARKDex",
        message: "Creature information for ARK: Survival Ascended."
    )
}

enum HomeViewState: Equatable, Sendable {
    case idle
    case loading
    case loaded(HomeContent)
    case empty
    case failed(HomeFailure)
}

enum HomeFailure: String, Equatable, Sendable {
    case unavailable
}
