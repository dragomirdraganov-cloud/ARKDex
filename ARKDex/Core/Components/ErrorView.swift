import SwiftUI

struct ErrorView: View {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let retryAction: (() -> Void)?

    init(
        title: LocalizedStringKey = "common.error.title",
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
                .accessibilityHidden(true)

            VStack(spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.textPrimary)

                Text(message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            if let retryAction {
                Button("common.retry", action: retryAction)
                    .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundPrimary)
    }
}

