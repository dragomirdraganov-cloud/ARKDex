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
        id: "starter-home",
        title: "SwiftUI + MVVM",
        message: "A reusable starter with typed navigation, dependency injection and deterministic tests."
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
