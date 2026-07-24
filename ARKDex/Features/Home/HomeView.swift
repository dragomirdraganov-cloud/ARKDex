import SwiftUI

struct HomeView: View {
    @State private var searchState: HomeSearchState

    private let searchFieldHeight: CGFloat = 56
    private let suggestionKeys = [
        "home.search.suggestion.one",
        "home.search.suggestion.two",
        "home.search.suggestion.three"
    ]

    init(initialQuery: String = "") {
        _searchState = State(initialValue: HomeSearchState(query: initialQuery))
    }

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary
                .ignoresSafeArea()

            VStack {
                Spacer()

                searchField
                    .frame(maxWidth: 520)
                    .padding(.horizontal, AppSpacing.lg)

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var searchField: some View {
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: AppTheme.cornerRadiusLarge,
            bottomLeadingRadius: searchState.showsSuggestions ? 0 : AppTheme.cornerRadiusLarge,
            bottomTrailingRadius: searchState.showsSuggestions ? 0 : AppTheme.cornerRadiusLarge,
            topTrailingRadius: AppTheme.cornerRadiusLarge
        )

        return HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppColors.textPrimary)
                .accessibilityHidden(true)

            TextField(
                "home.search.accessibility_label",
                text: $searchState.query,
                prompt: Text("home.search.placeholder")
                    .foregroundStyle(AppColors.border)
            )
            .font(AppTypography.body)
            .foregroundStyle(AppColors.textPrimary)
            .tint(AppColors.border)
            .submitLabel(.search)
            .accessibilityIdentifier("home.search.field")
        }
        .padding(.horizontal, AppSpacing.md)
        .frame(height: searchFieldHeight)
        .frame(maxWidth: .infinity)
        .background(AppColors.fieldBackground, in: shape)
        .overlay {
            shape.stroke(AppColors.border, lineWidth: 1.5)
        }
        .overlay(alignment: .top) {
            if searchState.showsSuggestions {
                suggestionsDropdown
                    .offset(y: searchFieldHeight - 1)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeOut(duration: 0.18), value: searchState.showsSuggestions)
        .zIndex(1)
    }

    private var suggestionsDropdown: some View {
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: 0,
            bottomLeadingRadius: AppTheme.cornerRadiusLarge,
            bottomTrailingRadius: AppTheme.cornerRadiusLarge,
            topTrailingRadius: 0
        )

        return VStack(spacing: 0) {
            ForEach(Array(suggestionKeys.enumerated()), id: \.offset) { index, suggestionKey in
                Text(LocalizedStringKey(suggestionKey))
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.vertical, AppSpacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if index < suggestionKeys.count - 1 {
                    Rectangle()
                        .fill(AppColors.border)
                        .frame(height: 1)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.fieldBackground, in: shape)
        .overlay {
            shape.stroke(AppColors.border, lineWidth: 1.5)
        }
        .accessibilityIdentifier("home.search.suggestions")
    }
}

#Preview("Home - Empty Search") {
    NavigationStack {
        HomeView()
    }
    .environment(\.locale, Locale(identifier: "es"))
}

#Preview("Home - Suggestions") {
    NavigationStack {
        HomeView(initialQuery: "Rex")
    }
    .environment(\.locale, Locale(identifier: "es"))
}

#Preview("Home - Accessibility") {
    NavigationStack {
        HomeView(initialQuery: "Rex")
    }
    .environment(\.locale, Locale(identifier: "en"))
    .dynamicTypeSize(.accessibility3)
}
