import Observation

@MainActor
@Observable
final class HomeViewModel {
    private(set) var state: ViewState<ExampleModel> = .idle

    private let exampleUseCase: ExampleUseCaseProtocol
    private var hasLoaded = false

    init(exampleUseCase: ExampleUseCaseProtocol) {
        self.exampleUseCase = exampleUseCase
    }

    func load(forceReload: Bool = false) async {
        guard forceReload || !hasLoaded else { return }

        state = .loading

        do {
            let model = try await exampleUseCase.execute()
            state = model.message.isEmpty ? .empty : .success(model)
            hasLoaded = true
        } catch is CancellationError {
            state = .idle
        } catch {
            state = .error("No se pudo cargar la informacion.")
        }
    }
}

