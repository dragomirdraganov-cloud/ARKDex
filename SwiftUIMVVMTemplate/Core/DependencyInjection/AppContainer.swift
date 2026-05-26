import SwiftUI

@MainActor
final class AppContainer {
    static let shared = AppContainer(environment: .current)
    static let preview = AppContainer(environment: .current)

    let environment: AppEnvironment
    let router = AppRouter()

    private init(environment: AppEnvironment) {
        self.environment = environment
    }

    var routerBinding: Binding<[AppRoute]> {
        router.pathBinding
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(exampleUseCase: makeExampleUseCase())
    }

    private func makeExampleUseCase() -> ExampleUseCaseProtocol {
        ExampleUseCase(repository: makeExampleRepository())
    }

    private func makeExampleRepository() -> ExampleRepositoryProtocol {
        ExampleRepository(dataSource: LocalExampleDataSource())
    }
}

