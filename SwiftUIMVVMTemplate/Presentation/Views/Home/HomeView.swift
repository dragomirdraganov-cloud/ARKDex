import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Inicio")
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            LoadingView(message: "Cargando contenido")
        case .success(let model):
            homeContent(model)
        case .empty:
            EmptyStateView(
                title: "Sin contenido",
                message: "No hay informacion disponible por ahora."
            )
        case .error(let message):
            ErrorView(message: LocalizedStringKey(message)) {
                Task {
                    await viewModel.load(forceReload: true)
                }
            }
        }
    }

    private func homeContent(_ model: ExampleModel) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.lg) {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text(model.title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.primaryText)

                Text(model.message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.secondaryText)
            }

            Text("La arquitectura base esta lista para crecer por features.")
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.secondaryText)
                .padding(AppSpacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.secondaryBackground, in: .rect(cornerRadius: AppTheme.cornerRadius))
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: AppContainer.preview.makeHomeViewModel())
    }
}
