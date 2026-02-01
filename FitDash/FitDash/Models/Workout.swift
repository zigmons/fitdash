import Foundation

struct Workout: Identifiable, Hashable {
    let id: UUID
    let type: String
    let duration: Double // seconds
    let date: Date
    let calories: Double
    let distance: Double? // meters (optional)

    // MARK: - Computed Properties

    var icon: String {
        switch type.lowercased() {
        case "corrida", "running":
            return "figure.run"
        case "musculação", "strength":
            return "dumbbell.fill"
        case "ciclismo", "cycling":
            return "bicycle"
        case "yoga":
            return "figure.yoga"
        case "caminhada", "walking":
            return "figure.walk"
        case "hiit":
            return "bolt.fill"
        case "natação", "swimming":
            return "figure.pool.swim"
        case "alongamento", "stretching":
            return "figure.flexibility"
        default:
            return "figure.mixed.cardio"
        }
    }

    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes) min"
        }
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")

        if Calendar.current.isDateInToday(date) {
            return "Hoje"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Ontem"
        } else {
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: date)
        }
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    var formattedDistance: String? {
        guard let distance = distance else { return nil }
        if distance >= 1000 {
            return String(format: "%.2f km", distance / 1000)
        } else {
            return String(format: "%.0f m", distance)
        }
    }

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Workout, rhs: Workout) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Workout Type Enum (for filtering)
enum WorkoutType: String, CaseIterable {
    case all = "Todos"
    case running = "Corrida"
    case strength = "Musculação"
    case cycling = "Ciclismo"
    case yoga = "Yoga"
    case hiit = "HIIT"
    case walking = "Caminhada"
    case swimming = "Natação"

    var icon: String {
        switch self {
        case .all: return "list.bullet"
        case .running: return "figure.run"
        case .strength: return "dumbbell.fill"
        case .cycling: return "bicycle"
        case .yoga: return "figure.yoga"
        case .hiit: return "bolt.fill"
        case .walking: return "figure.walk"
        case .swimming: return "figure.pool.swim"
        }
    }
}
