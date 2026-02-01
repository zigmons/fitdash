import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
                .tag(0)

            WorkoutListView()
                .tabItem {
                    Label("Treinos", systemImage: "figure.run")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .tint(.primaryStart)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
