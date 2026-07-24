import Foundation

@MainActor
struct AppDependencies {
    let configuration: AppConfiguration
    let homeService: any HomeService
    let keyValueStore: any KeyValueStore

    static func live(configuration: AppConfiguration) -> AppDependencies {
        let transport = URLSessionHTTPTransport(session: .shared)
        let apiClient = APIClient(transport: transport)

        let homeService: any HomeService = switch configuration.environment {
        case .development:
            HomeServiceMock(mode: .success(.preview))
        case .production:
            HomeServiceLive(
                apiClient: apiClient,
                baseURL: configuration.apiBaseURL,
                timeout: configuration.requestTimeout
            )
        }

        return AppDependencies(
            configuration: configuration,
            homeService: homeService,
            keyValueStore: UserDefaultsKeyValueStore()
        )
    }

    static func preview(
        homeMode: HomeServiceMock.Mode = .success(.preview)
    ) -> AppDependencies {
        AppDependencies(
            configuration: AppConfiguration(
                appName: "MVVM Starter",
                environment: .development,
                apiBaseURL: URL(fileURLWithPath: "/"),
                requestTimeout: 1
            ),
            homeService: HomeServiceMock(mode: homeMode),
            keyValueStore: InMemoryKeyValueStore()
        )
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(service: homeService)
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(store: keyValueStore)
    }
}
