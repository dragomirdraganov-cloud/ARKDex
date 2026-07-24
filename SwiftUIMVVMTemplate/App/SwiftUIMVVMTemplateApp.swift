import SwiftUI

@main
@MainActor
struct SwiftUIMVVMTemplateApp: App {
    private let dependencies: AppDependencies

    init() {
        dependencies = .live(configuration: .current)
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(dependencies: dependencies)
        }
    }
}

