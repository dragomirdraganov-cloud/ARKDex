import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.headline)
            .foregroundStyle(AppColors.textPrimary)
            .padding(.horizontal, AppSpacing.lg)
            .frame(minHeight: 44)
            .background(
                configuration.isPressed
                    ? AppColors.border
                    : AppColors.actionBackground,
                in: .rect(cornerRadius: AppTheme.cornerRadius)
            )
    }
}
