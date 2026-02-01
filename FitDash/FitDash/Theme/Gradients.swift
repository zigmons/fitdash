import SwiftUI

struct AppGradients {
    // MARK: - Primary Gradient (Purple/Violet)
    static let primary = LinearGradient(
        colors: [.primaryStart, .primaryEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Secondary Gradient (Cyan/Blue)
    static let secondary = LinearGradient(
        colors: [.secondaryStart, .secondaryEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Accent Gradient (Pink)
    static let accent = LinearGradient(
        colors: [.accentStart, .accentEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Success Gradient (Green/Fitness)
    static let success = LinearGradient(
        colors: [.successStart, .successEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Background Gradient
    static let backgroundGradient = LinearGradient(
        colors: [.background, .surface],
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Workout Type Gradients
    static func gradient(for workoutType: String) -> LinearGradient {
        switch workoutType.lowercased() {
        case "corrida", "running", "caminhada":
            return success
        case "musculação", "strength", "peso":
            return primary
        case "ciclismo", "cycling", "bike":
            return secondary
        case "yoga", "alongamento", "stretching":
            return accent
        case "hiit", "crossfit", "funcional":
            return LinearGradient(
                colors: [.accentEnd, .primaryStart],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return primary
        }
    }
}

// MARK: - Gradient View Modifier
struct GradientBackground: ViewModifier {
    let gradient: LinearGradient

    func body(content: Content) -> some View {
        content
            .background(gradient)
    }
}

extension View {
    func gradientBackground(_ gradient: LinearGradient = AppGradients.primary) -> some View {
        modifier(GradientBackground(gradient: gradient))
    }
}
