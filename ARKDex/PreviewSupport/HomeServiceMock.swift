struct HomeServiceMock: HomeService {
    enum Mode: Sendable {
        case success(HomeContent)
        case empty
        case failure
    }

    let mode: Mode

    func fetchHome() async throws -> HomeContent {
        switch mode {
        case .success(let content):
            content
        case .empty:
            HomeContent(id: "empty", title: "", message: "")
        case .failure:
            throw HomeServiceError.unavailable
        }
    }
}

