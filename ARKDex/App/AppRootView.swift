import SwiftUI

@MainActor
struct AppRootView: View {
    @State private var appState: AppState
    @State private var router: AppRouter
    @State private var settingsViewModel: SettingsViewModel

    init(dependencies: AppDependencies) {
        _appState = State(initialValue: AppState())
        _router = State(initialValue: AppRouter())
        _settingsViewModel = State(initialValue: dependencies.makeSettingsViewModel())
    }

    var body: some View {
        @Bindable var appState = appState
        @Bindable var router = router

        TabView(selection: $appState.selectedTab) {
            NavigationStack(path: $router.homePath) {
                HomeView()
            }
            .tabItem {
                Label("app.tab.home", systemImage: "house")
            }
            .tag(AppTab.home)

            NavigationStack(path: $router.settingsPath) {
                SettingsView(viewModel: settingsViewModel)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .tabItem {
                Label("app.tab.settings", systemImage: "gearshape")
            }
            .tag(AppTab.settings)
        }
        .font(AppTypography.body)
        .tint(AppColors.textPrimary)
        .toolbarBackground(AppColors.fieldBackground, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .detail(let itemID):
            ExampleDetailView(itemID: itemID)
        }
    }
}

#Preview("App - Light EN") {
    AppRootView(dependencies: .preview())
        .environment(\.locale, Locale(identifier: "en"))
        .preferredColorScheme(.light)
}

#Preview("App - Dark ES") {
    AppRootView(dependencies: .preview())
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
}
