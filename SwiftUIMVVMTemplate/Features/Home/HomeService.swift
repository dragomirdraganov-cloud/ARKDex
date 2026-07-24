protocol HomeService: Sendable {
    func fetchHome() async throws -> HomeContent
}

enum HomeServiceError: Error, Equatable, Sendable {
    case unavailable
}

