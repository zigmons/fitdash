import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content
    var padding: CGFloat = 20
    var cornerRadius: CGFloat = 20

    init(
        padding: CGFloat = 20,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .shadow(color: Color.primaryStart.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Glass Card Modifier
struct GlassCardModifier: ViewModifier {
    var padding: CGFloat = 20
    var cornerRadius: CGFloat = 20

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .shadow(color: Color.primaryStart.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func glassCard(padding: CGFloat = 20, cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassCardModifier(padding: padding, cornerRadius: cornerRadius))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.background.ignoresSafeArea()

        VStack(spacing: 20) {
            GlassCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Glass Card")
                        .font(AppTypography.headline)
                        .foregroundColor(.textPrimary)

                    Text("This is a glassmorphism card with blur effect")
                        .font(AppTypography.subheadline)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Text("Using modifier")
                .font(AppTypography.headline)
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassCard()
        }
        .padding()
    }
}
