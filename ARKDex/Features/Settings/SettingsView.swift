import SwiftUI

struct SettingsView: View {
    @State private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        @Bindable var viewModel = viewModel

        Form {
            Section {
                Toggle(
                    "settings.analytics.title",
                    isOn: $viewModel.isAnalyticsEnabled
                )

                Text("settings.analytics.description")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }

            Section {
                Button("settings.save") {
                    Task {
                        await viewModel.save()
                    }
                }
                .disabled(viewModel.isLoading || viewModel.isSaving)

                switch viewModel.saveState {
                case .idle:
                    EmptyView()
                case .saved:
                    Label("settings.saved", systemImage: "checkmark.circle")
                        .foregroundStyle(AppColors.success)
                case .failed:
                    Label("settings.save_error", systemImage: "exclamationmark.triangle")
                        .foregroundStyle(AppColors.error)
                }
            }
        }
        .navigationTitle("settings.navigation_title")
        .task {
            await viewModel.load()
        }
    }
}

#Preview("Settings - ES") {
    NavigationStack {
        SettingsView(viewModel: SettingsViewModel(store: InMemoryKeyValueStore()))
    }
    .environment(\.locale, Locale(identifier: "es"))
}

