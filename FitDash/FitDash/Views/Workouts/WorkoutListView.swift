import SwiftUI

struct WorkoutListView: View {
    @State private var searchText = ""
    @State private var selectedFilter: WorkoutType = .all
    @State private var isRefreshing = false

    private var filteredWorkouts: [Workout] {
        var workouts = PreviewData.workouts

        // Filter by type
        if selectedFilter != .all {
            workouts = workouts.filter {
                $0.type.lowercased() == selectedFilter.rawValue.lowercased()
            }
        }

        // Filter by search
        if !searchText.isEmpty {
            workouts = workouts.filter {
                $0.type.lowercased().contains(searchText.lowercased())
            }
        }

        return workouts
    }

    private var groupedWorkouts: [(String, [Workout])] {
        let grouped = Dictionary(grouping: filteredWorkouts) { workout -> String in
            workout.formattedDate
        }

        return grouped.sorted { first, second in
            let firstDate = filteredWorkouts.first { $0.formattedDate == first.key }?.date ?? Date.distantPast
            let secondDate = filteredWorkouts.first { $0.formattedDate == second.key }?.date ?? Date.distantPast
            return firstDate > secondDate
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    headerView

                    // Filter chips
                    filterScrollView

                    // Workout list
                    if filteredWorkouts.isEmpty {
                        emptyStateView
                    } else {
                        workoutList
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Treinos")
                    .font(AppTypography.largeTitle)
                    .foregroundColor(.textPrimary)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(AppGradients.primary)
                }
            }

            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.textSecondary)

                TextField("Buscar treinos...", text: $searchText)
                    .foregroundColor(.textPrimary)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
            )
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }

    // MARK: - Filter Scroll View
    private var filterScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    FilterChip(
                        title: type.rawValue,
                        icon: type.icon,
                        isSelected: selectedFilter == type
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedFilter = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
    }

    // MARK: - Workout List
    private var workoutList: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(groupedWorkouts, id: \.0) { dateGroup, workouts in
                    VStack(alignment: .leading, spacing: 12) {
                        // Date header
                        Text(dateGroup)
                            .font(AppTypography.headline)
                            .foregroundColor(.textSecondary)
                            .padding(.horizontal)

                        // Workout rows
                        VStack(spacing: 8) {
                            ForEach(workouts) { workout in
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutRow(workout: workout)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
            .padding(.bottom, 100) // Tab bar space
        }
        .refreshable {
            // Simulate refresh
            isRefreshing = true
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            isRefreshing = false
        }
    }

    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "figure.run.circle")
                .font(.system(size: 60))
                .foregroundStyle(AppGradients.primary)

            Text("Nenhum treino encontrado")
                .font(AppTypography.title3)
                .foregroundColor(.textPrimary)

            Text("Tente ajustar os filtros ou comece um novo treino")
                .font(AppTypography.subheadline)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)

            GradientButton(
                title: "Novo Treino",
                icon: "plus",
                isFullWidth: false
            ) {}

            Spacer()
        }
        .padding()
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))

                Text(title)
                    .font(AppTypography.subheadline)
            }
            .foregroundColor(isSelected ? .white : .textSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? AnyShapeStyle(AppGradients.primary) : AnyShapeStyle(.ultraThinMaterial))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(isSelected ? 0 : 0.1), lineWidth: 1)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    WorkoutListView()
        .preferredColorScheme(.dark)
}
