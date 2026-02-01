import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Header with gradient
                    headerView

                    // Stats section
                    statsSection

                    // Timeline placeholder
                    timelineSection

                    // Notes placeholder
                    notesSection
                }
                .padding(.bottom, 100)
            }
        }
        .navigationBarHidden(true)
        .overlay(alignment: .top) {
            customNavigationBar
        }
    }

    // MARK: - Custom Navigation Bar
    private var customNavigationBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                    )
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: - Header View
    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient background
            RoundedRectangle(cornerRadius: 0)
                .fill(AppGradients.gradient(for: workout.type))
                .frame(height: 220)
                .overlay(
                    // Overlay pattern
                    Image(systemName: workout.icon)
                        .font(.system(size: 120))
                        .foregroundColor(.white.opacity(0.1))
                        .offset(x: 100, y: -20)
                )

            // Workout info
            VStack(alignment: .leading, spacing: 8) {
                Text(workout.type)
                    .font(AppTypography.largeTitle)
                    .foregroundColor(.white)

                HStack(spacing: 16) {
                    Label(workout.formattedDate, systemImage: "calendar")
                    Label(workout.formattedTime, systemImage: "clock")
                }
                .font(AppTypography.subheadline)
                .foregroundColor(.white.opacity(0.9))
            }
            .padding(24)
        }
    }

    // MARK: - Stats Section
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Estatísticas")
                .font(AppTypography.title3)
                .foregroundColor(.textPrimary)
                .padding(.horizontal)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                StatCard(
                    icon: "clock.fill",
                    value: workout.formattedDuration,
                    label: "Duração",
                    gradient: AppGradients.primary
                )

                StatCard(
                    icon: "flame.fill",
                    value: "\(Int(workout.calories))",
                    label: "Calorias",
                    gradient: AppGradients.accent
                )

                if let distance = workout.formattedDistance {
                    StatCard(
                        icon: "map.fill",
                        value: distance,
                        label: "Distância",
                        gradient: AppGradients.success
                    )
                }

                StatCard(
                    icon: "heart.fill",
                    value: "145",
                    label: "BPM Médio",
                    gradient: AppGradients.secondary
                )
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Timeline Section
    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Timeline")
                .font(AppTypography.title3)
                .foregroundColor(.textPrimary)
                .padding(.horizontal)

            GlassCard {
                VStack(alignment: .leading, spacing: 16) {
                    timelineItem(
                        time: "00:00",
                        title: "Início",
                        subtitle: "Aquecimento",
                        icon: "play.fill"
                    )

                    timelineItem(
                        time: "05:00",
                        title: "Fase Principal",
                        subtitle: "Intensidade alta",
                        icon: "bolt.fill"
                    )

                    timelineItem(
                        time: workout.formattedDuration,
                        title: "Fim",
                        subtitle: "Desaquecimento",
                        icon: "checkmark.circle.fill"
                    )
                }
            }
            .padding(.horizontal)
        }
    }

    private func timelineItem(time: String, title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 16) {
            // Time
            Text(time)
                .font(AppTypography.caption)
                .foregroundColor(.textSecondary)
                .frame(width: 50, alignment: .leading)

            // Dot and line
            VStack(spacing: 0) {
                Circle()
                    .fill(AppGradients.gradient(for: workout.type))
                    .frame(width: 12, height: 12)
            }

            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundColor(.textPrimary)

                Text(subtitle)
                    .font(AppTypography.caption)
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            Image(systemName: icon)
                .foregroundStyle(AppGradients.gradient(for: workout.type))
        }
    }

    // MARK: - Notes Section
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Notas")
                .font(AppTypography.title3)
                .foregroundColor(.textPrimary)
                .padding(.horizontal)

            GlassCard {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundStyle(AppGradients.primary)

                        Text("Observações do treino")
                            .font(AppTypography.headline)
                            .foregroundColor(.textPrimary)
                    }

                    Text("Treino concluído com sucesso. Mantive boa forma durante toda a sessão. Próximo treino: aumentar carga em 5%.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        WorkoutDetailView(workout: PreviewData.workouts[0])
    }
    .preferredColorScheme(.dark)
}
