import Foundation

struct AppConfiguration: Sendable, Equatable {
    let appName: String
    let environment: BuildEnvironment
    let apiBaseURL: URL
    let requestTimeout: TimeInterval

    static var current: AppConfiguration {
        let info = Bundle.main.infoDictionary ?? [:]

        guard
            let appName = info["CFBundleDisplayName"] as? String,
            let environmentValue = info["APP_ENVIRONMENT"] as? String,
            let environment = BuildEnvironment(rawValue: environmentValue),
            let baseURLValue = info["API_BASE_URL"] as? String,
            let baseURL = URL(string: baseURLValue),
            let scheme = baseURL.scheme,
            !scheme.isEmpty
        else {
            preconditionFailure("Invalid app configuration. Check Config/*.xcconfig.")
        }

        return AppConfiguration(
            appName: appName,
            environment: environment,
            apiBaseURL: baseURL,
            requestTimeout: 15
        )
    }
}

enum BuildEnvironment: String, Sendable, Equatable {
    case development
    case production
}

