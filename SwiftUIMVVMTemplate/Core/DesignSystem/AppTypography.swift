import SwiftUI

enum AppTypography {
    static let title = Font.custom(
        "Montserrat-Bold",
        size: 28,
        relativeTo: .title
    )

    static let headline = Font.custom(
        "Montserrat-SemiBold",
        size: 17,
        relativeTo: .headline
    )

    static let body = Font.custom(
        "Montserrat-Regular",
        size: 17,
        relativeTo: .body
    )

    static let caption = Font.custom(
        "Montserrat-Regular",
        size: 12,
        relativeTo: .caption
    )
}
