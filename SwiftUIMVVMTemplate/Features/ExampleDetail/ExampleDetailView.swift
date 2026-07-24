import SwiftUI

struct ExampleDetailView: View {
    let itemID: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("detail.title")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("detail.message")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)

            Text(itemID)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textPrimary)
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.backgroundPrimary)
        .navigationTitle("detail.navigation_title")
    }
}
