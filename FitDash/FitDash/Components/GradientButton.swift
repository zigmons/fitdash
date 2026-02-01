import SwiftUI

struct GradientButton: View {
    let title: String
    let gradient: LinearGradient
    let action: () -> Void

    var icon: String? = nil
    var isFullWidth: Bool = true
    var height: CGFloat = 56

    init(
        title: String,
        icon: String? = nil,
        gradient: LinearGradient = AppGradients.primary,
        isFullWidth: Bool = true,
        height: CGFloat = 56,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.gradient = gradient
        self.isFullWidth = isFullWidth
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                }

                Text(title)
                    .font(AppTypography.headline)
            }
            .foregroundColor(.white)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: height)
            .padding(.horizontal, isFullWidth ? 0 : 24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(gradient)
            )
            .shadow(color: Color.primaryStart.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Scale Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Secondary Button Style
struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var icon: String? = nil

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                }

                Text(title)
                    .font(AppTypography.subheadline)
            }
            .foregroundColor(.textPrimary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.background.ignoresSafeArea()

        VStack(spacing: 20) {
            GradientButton(title: "Start Workout", icon: "play.fill") {
                print("Button tapped")
            }

            GradientButton(
                title: "Success",
                icon: "checkmark.circle.fill",
                gradient: AppGradients.success
            ) {}

            GradientButton(
                title: "Compact",
                gradient: AppGradients.accent,
                isFullWidth: false
            ) {}

            SecondaryButton(title: "Cancel", icon: "xmark") {}
        }
        .padding()
    }
}
