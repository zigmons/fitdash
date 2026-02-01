import Foundation

struct PreviewData {
    static let workouts: [Workout] = [
        Workout(
            id: UUID(),
            type: "Corrida",
            duration: 2700, // 45 min
            date: Date(),
            calories: 420,
            distance: 6500
        ),
        Workout(
            id: UUID(),
            type: "Musculação",
            duration: 3600, // 1h
            date: Date().addingTimeInterval(-86400), // yesterday
            calories: 350,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "Yoga",
            duration: 1800, // 30 min
            date: Date().addingTimeInterval(-86400), // yesterday
            calories: 120,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "HIIT",
            duration: 1200, // 20 min
            date: Date().addingTimeInterval(-172800), // 2 days ago
            calories: 280,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "Ciclismo",
            duration: 5400, // 1h 30min
            date: Date().addingTimeInterval(-172800), // 2 days ago
            calories: 550,
            distance: 25000
        ),
        Workout(
            id: UUID(),
            type: "Caminhada",
            duration: 2400, // 40 min
            date: Date().addingTimeInterval(-259200), // 3 days ago
            calories: 180,
            distance: 3200
        ),
        Workout(
            id: UUID(),
            type: "Musculação",
            duration: 4200, // 1h 10min
            date: Date().addingTimeInterval(-345600), // 4 days ago
            calories: 400,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "Corrida",
            duration: 1800, // 30 min
            date: Date().addingTimeInterval(-432000), // 5 days ago
            calories: 320,
            distance: 5000
        ),
        Workout(
            id: UUID(),
            type: "Natação",
            duration: 2700, // 45 min
            date: Date().addingTimeInterval(-518400), // 6 days ago
            calories: 380,
            distance: 1500
        ),
        Workout(
            id: UUID(),
            type: "HIIT",
            duration: 900, // 15 min
            date: Date().addingTimeInterval(-604800), // 7 days ago
            calories: 220,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "Yoga",
            duration: 3600, // 1h
            date: Date().addingTimeInterval(-691200), // 8 days ago
            calories: 150,
            distance: nil
        ),
        Workout(
            id: UUID(),
            type: "Ciclismo",
            duration: 7200, // 2h
            date: Date().addingTimeInterval(-777600), // 9 days ago
            calories: 720,
            distance: 40000
        )
    ]

    // MARK: - Summary Statistics
    static var totalWorkoutsThisWeek: Int {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workouts.filter { $0.date >= startOfWeek }.count
    }

    static var totalDurationThisWeek: Double {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workouts.filter { $0.date >= startOfWeek }.reduce(0) { $0 + $1.duration }
    }

    static var totalCaloriesThisWeek: Double {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workouts.filter { $0.date >= startOfWeek }.reduce(0) { $0 + $1.calories }
    }

    static func formattedTotalDuration(_ duration: Double) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes) min"
        }
    }

    // MARK: - Grouped by Date
    static var workoutsGroupedByDate: [(String, [Workout])] {
        let grouped = Dictionary(grouping: workouts) { workout -> String in
            workout.formattedDate
        }

        return grouped.sorted { first, second in
            let firstDate = workouts.first { $0.formattedDate == first.key }?.date ?? Date.distantPast
            let secondDate = workouts.first { $0.formattedDate == second.key }?.date ?? Date.distantPast
            return firstDate > secondDate
        }
    }
}
