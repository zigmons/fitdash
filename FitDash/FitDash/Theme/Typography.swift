import SwiftUI

struct AppTypography {
    // MARK: - Large Title
    static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)

    // MARK: - Title
    static let title = Font.system(size: 28, weight: .bold, design: .rounded)

    // MARK: - Title 2
    static let title2 = Font.system(size: 22, weight: .semibold, design: .rounded)

    // MARK: - Title 3
    static let title3 = Font.system(size: 20, weight: .semibold, design: .rounded)

    // MARK: - Headline
    static let headline = Font.system(size: 17, weight: .semibold, design: .rounded)

    // MARK: - Body
    static let body = Font.system(size: 17, weight: .regular, design: .default)

    // MARK: - Callout
    static let callout = Font.system(size: 16, weight: .regular, design: .default)

    // MARK: - Subheadline
    static let subheadline = Font.system(size: 15, weight: .regular, design: .default)

    // MARK: - Footnote
    static let footnote = Font.system(size: 13, weight: .regular, design: .default)

    // MARK: - Caption
    static let caption = Font.system(size: 12, weight: .regular, design: .default)

    // MARK: - Caption 2
    static let caption2 = Font.system(size: 11, weight: .regular, design: .default)

    // MARK: - Stat Value (for numbers)
    static let statValue = Font.system(size: 32, weight: .bold, design: .rounded)

    // MARK: - Stat Label
    static let statLabel = Font.system(size: 14, weight: .medium, design: .rounded)
}

// MARK: - Text Style Modifier
struct TextStyle: ViewModifier {
    let font: Font
    let color: Color

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension View {
    func textStyle(_ font: Font, color: Color = .textPrimary) -> some View {
        modifier(TextStyle(font: font, color: color))
    }
}
