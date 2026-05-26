import SwiftUI

struct LoadingView: View {
    let message: LocalizedStringKey

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()
                .controlSize(.large)

            Text(message)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}

#Preview {
    LoadingView(message: "Cargando contenido")
}

