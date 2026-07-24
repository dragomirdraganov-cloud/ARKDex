import SwiftUI

struct LoadingView: View {
    let message: LocalizedStringKey

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()
                .controlSize(.large)

            Text(message)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundPrimary)
    }
}

