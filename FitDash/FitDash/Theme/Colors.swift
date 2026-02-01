import SwiftUI

extension Color {
    // MARK: - Primary Gradient Colors
    static let primaryStart = Color(hex: "667EEA")
    static let primaryEnd = Color(hex: "764BA2")

    // MARK: - Secondary Gradient Colors
    static let secondaryStart = Color(hex: "06B6D4")
    static let secondaryEnd = Color(hex: "3B82F6")

    // MARK: - Accent Gradient Colors
    static let accentStart = Color(hex: "F472B6")
    static let accentEnd = Color(hex: "EC4899")

    // MARK: - Success Gradient Colors
    static let successStart = Color(hex: "10B981")
    static let successEnd = Color(hex: "059669")

    // MARK: - Base Colors (Dark Mode)
    static let background = Color(hex: "0F0F1A")
    static let surface = Color(hex: "1A1A2E")
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "A0AEC0")

    // MARK: - Hex Initializer
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
