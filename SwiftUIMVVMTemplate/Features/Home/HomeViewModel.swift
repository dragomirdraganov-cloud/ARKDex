import Observation

@MainActor
@Observable
final class HomeViewModel {
    private(set) var state: HomeViewState

    private let service: any HomeService
    private var hasLoaded = false

    init(
        service: any HomeService,
        initialState: HomeViewState = .idle
    ) {
        self.service = service
        state = initialState
        hasLoaded = initialState != .idle
    }

    func load(forceReload: Bool = false) async {
        guard forceReload || !hasLoaded else { return }
        state = .loading

        do {
            let content = try await service.fetchHome()
            state = content.message.isEmpty ? .empty : .loaded(content)
            hasLoaded = true
        } catch is CancellationError {
            state = .idle
        } catch {
            state = .failed(.unavailable)
        }
    }
}

