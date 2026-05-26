protocol ExampleDataSource {
    func fetchExampleDTO() async throws -> ExampleDTO
}

struct LocalExampleDataSource: ExampleDataSource {
    func fetchExampleDTO() async throws -> ExampleDTO {
        try await Task.sleep(for: .milliseconds(300))

        return ExampleDTO(
            id: "D73BD3A9-2F2B-4E16-A37C-BB54B0BB1D6A",
            title: "SwiftUI + MVVM",
            message: "Proyecto base con capas, inyeccion de dependencias y estado de pantalla."
        )
    }
}
