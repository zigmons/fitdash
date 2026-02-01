import SwiftUI

struct DashboardView: View {
    @State private var workouts = PreviewData.workouts

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            return "Bom dia"
        case 12..<18:
            return "Boa tarde"
        default:
            return "Boa noite"
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header with greeting
                        headerView

                        // Stats Grid
                        statsGrid

                        // Weekly Progress Chart Placeholder
                        weeklyProgressSection

                        // Recent Workouts
                        recentWorkoutsSection
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100) // Tab bar space
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(greeting)
                .font(AppTypography.title2)
                .foregroundColor(.textSecondary)

            Text("Atleta!")
                .font(AppTypography.largeTitle)
                .foregroundStyle(AppGradients.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
    }

    // MARK: - Stats Grid
    private var statsGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            StatCard(
                icon: "flame.fill",
                value: "\(Int(PreviewData.totalCaloriesThisWeek))",
                label: "Calorias Semana",
                gradient: AppGradients.accent
            )

            StatCard(
                icon: "clock.fill",
                value: PreviewData.formattedTotalDuration(PreviewData.totalDurationThisWeek),
                label: "Tempo Total",
                gradient: AppGradients.primary
            )

            StatCard(
                icon: "figure.run",
                value: "\(PreviewData.totalWorkoutsThisWeek)",
                label: "Treinos Semana",
                gradient: AppGradients.success
            )

            StatCard(
                icon: "chart.line.uptrend.xyaxis",
                value: "7",
                label: "Dias Seguidos",
                gradient: AppGradients.secondary
            )
        }
    }

    // MARK: - Weekly Progress Section
    private var weeklyProgressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Progresso Semanal")
                .font(AppTypography.title3)
                .foregroundColor(.textPrimary)

            // Chart placeholder
            GlassCard {
                VStack(spacing: 16) {
                    HStack(alignment: .bottom, spacing: 8) {
                        ForEach(0..<7, id: \.self) { day in
                            VStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(AppGradients.primary)
                                    .frame(width: 36, height: chartBarHeight(for: day))

                                Text(dayLabel(for: day))
                                    .font(AppTypography.caption2)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                }
            }
        }
    }

    private func chartBarHeight(for day: Int) -> CGFloat {
        let heights: [CGFloat] = [60, 80, 45, 100, 70, 90, 50]
        return heights[day]
    }

    private func dayLabel(for day: Int) -> String {
        let labels = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"]
        return labels[day]
    }

    // MARK: - Recent Workouts Section
    private var recentWorkoutsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Treinos Recentes")
                    .font(AppTypography.title3)
                    .foregroundColor(.textPrimary)

                Spacer()

                NavigationLink(destination: WorkoutListView()) {
                    Text("Ver Todos")
                        .font(AppTypography.subheadline)
                        .foregroundColor(.primaryStart)
                }
            }

            VStack(spacing: 12) {
                ForEach(Array(workouts.prefix(3))) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        WorkoutRow(workout: workout)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DashboardView()
        .preferredColorScheme(.dark)
}
