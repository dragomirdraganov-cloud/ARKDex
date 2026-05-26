import SwiftUI

@main
struct SwiftUIMVVMTemplateApp: App {
    private let container = AppContainer.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: container.routerBinding) {
                HomeView(viewModel: container.makeHomeViewModel())
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .environment(container.router)
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView(viewModel: container.makeHomeViewModel())
        case .detail(let id):
            Text("Detalle \(id)")
                .font(AppTypography.title)
                .padding(AppSpacing.md)
        }
    }
}

