import SwiftUI

struct ErrorView: View {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let retryAction: (() -> Void)?

    init(
        title: LocalizedStringKey = "Algo no ha ido bien",
        message: LocalizedStringKey,
        retryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(AppColors.error)

            VStack(spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText)

                Text(message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
            }

            if let retryAction {
                Button("Reintentar", action: retryAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}

#Preview {
    ErrorView(message: "No se pudo cargar la informacion.") {}
}

