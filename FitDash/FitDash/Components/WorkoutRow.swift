import SwiftUI

struct WorkoutRow: View {
    let workout: Workout

    var body: some View {
        HStack(spacing: 16) {
            // Workout type icon with gradient
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppGradients.gradient(for: workout.type).opacity(0.2))
                    .frame(width: 50, height: 50)

                Image(systemName: workout.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(AppGradients.gradient(for: workout.type))
            }

            // Workout info
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.type)
                    .font(AppTypography.headline)
                    .foregroundColor(.textPrimary)

                HStack(spacing: 12) {
                    Label(workout.formattedDuration, systemImage: "clock")
                    if let distance = workout.distance {
                        Label(String(format: "%.1f km", distance / 1000), systemImage: "map")
                    }
                }
                .font(AppTypography.caption)
                .foregroundColor(.textSecondary)
            }

            Spacer()

            // Calories and chevron
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(workout.calories))")
                    .font(AppTypography.headline)
                    .foregroundColor(.textPrimary)

                Text("kcal")
                    .font(AppTypography.caption)
                    .foregroundColor(.textSecondary)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textSecondary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.background.ignoresSafeArea()

        VStack(spacing: 12) {
            WorkoutRow(workout: PreviewData.workouts[0])
            WorkoutRow(workout: PreviewData.workouts[1])
            WorkoutRow(workout: PreviewData.workouts[2])
        }
        .padding()
    }
}
