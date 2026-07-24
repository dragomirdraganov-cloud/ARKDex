import Testing
@testable import SwiftUIMVVMTemplate

@MainActor
struct HomeViewModelTests {
    @Test
    func loadsContent() async {
        let content = HomeContent.preview
        let viewModel = HomeViewModel(
            service: HomeServiceMock(mode: .success(content))
        )

        await viewModel.load()

        #expect(viewModel.state == .loaded(content))
    }

    @Test
    func mapsEmptyContentToEmptyState() async {
        let viewModel = HomeViewModel(
            service: HomeServiceMock(mode: .empty)
        )

        await viewModel.load()

        #expect(viewModel.state == .empty)
    }

    @Test
    func retriesAfterFailure() async {
        let service = SequencedHomeService(
            results: [
                .failure(.unavailable),
                .success(.preview)
            ]
        )
        let viewModel = HomeViewModel(service: service)

        await viewModel.load()
        #expect(viewModel.state == .failed(.unavailable))

        await viewModel.load(forceReload: true)
        #expect(viewModel.state == .loaded(.preview))
    }
}

private actor SequencedHomeService: HomeService {
    private var results: [Result<HomeContent, HomeServiceError>]

    init(results: [Result<HomeContent, HomeServiceError>]) {
        self.results = results
    }

    func fetchHome() throws -> HomeContent {
        guard !results.isEmpty else {
            throw HomeServiceError.unavailable
        }
        return try results.removeFirst().get()
    }
}

