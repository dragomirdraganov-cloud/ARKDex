protocol ExampleUseCaseProtocol {
    func execute() async throws -> ExampleModel
}

struct ExampleUseCase: ExampleUseCaseProtocol {
    private let repository: ExampleRepositoryProtocol

    init(repository: ExampleRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> ExampleModel {
        try await repository.fetchExample()
    }
}

