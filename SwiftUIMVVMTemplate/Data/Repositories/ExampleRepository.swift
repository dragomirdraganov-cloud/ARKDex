struct ExampleRepository: ExampleRepositoryProtocol {
    private let dataSource: ExampleDataSource

    init(dataSource: ExampleDataSource) {
        self.dataSource = dataSource
    }

    func fetchExample() async throws -> ExampleModel {
        let dto = try await dataSource.fetchExampleDTO()
        return ExampleMapper.map(dto)
    }
}

