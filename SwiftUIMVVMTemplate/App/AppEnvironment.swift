struct AppEnvironment {
    let configuration: AppConfig

    static let current = AppEnvironment(configuration: .current)
}

