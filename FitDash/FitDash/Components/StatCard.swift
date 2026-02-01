import SwiftUI

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    var gradient: LinearGradient = AppGradients.primary

    var body: some View {
        GlassCard(padding: 16) {
            VStack(alignment: .leading, spacing: 12) {
                // Icon with gradient background
                ZStack {
                    Circle()
                        .fill(gradient.opacity(0.2))
                        .frame(width: 44, height: 44)

                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(gradient)
                }

                // Value
                Text(value)
                    .font(AppTypography.statValue)
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                // Label
                Text(label)
                    .font(AppTypography.statLabel)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Compact Stat Card
struct CompactStatCard: View {
    let icon: String
    let value: String
    let label: String
    var gradient: LinearGradient = AppGradients.primary

    var body: some View {
        HStack(spacing: 12) {
            // Icon with gradient background
            ZStack {
                Circle()
                    .fill(gradient.opacity(0.2))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(gradient)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(AppTypography.headline)
                    .foregroundColor(.textPrimary)

                Text(label)
                    .font(AppTypography.caption)
                    .foregroundColor(.textSecondary)
            }

            Spacer()
        }
        .glassCard(padding: 12, cornerRadius: 16)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.background.ignoresSafeArea()

        ScrollView {
            VStack(spacing: 16) {
                // Grid of stat cards
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    StatCard(
                        icon: "flame.fill",
                        value: "1,234",
                        label: "Calorias",
                        gradient: AppGradients.accent
                    )

                    StatCard(
                        icon: "clock.fill",
                        value: "4h 32m",
                        label: "Tempo Total",
                        gradient: AppGradients.primary
                    )

                    StatCard(
                        icon: "figure.run",
                        value: "12",
                        label: "Treinos",
                        gradient: AppGradients.success
                    )

                    StatCard(
                        icon: "chart.line.uptrend.xyaxis",
                        value: "+15%",
                        label: "Progresso",
                        gradient: AppGradients.secondary
                    )
                }

                // Compact cards
                CompactStatCard(
                    icon: "heart.fill",
                    value: "142 bpm",
                    label: "Freq. Cardíaca Média",
                    gradient: AppGradients.accent
                )

                CompactStatCard(
                    icon: "map.fill",
                    value: "5.2 km",
                    label: "Distância Hoje",
                    gradient: AppGradients.success
                )
            }
            .padding()
        }
    }
}
