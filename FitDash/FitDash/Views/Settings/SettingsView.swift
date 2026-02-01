import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @AppStorage("useDecimalTime") private var useDecimalTime = false
    @State private var showingAbout = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        headerView

                        // Appearance section
                        appearanceSection

                        // Preferences section
                        preferencesSection

                        // About section
                        aboutSection

                        // App info
                        appInfoView
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            Text("Ajustes")
                .font(AppTypography.largeTitle)
                .foregroundColor(.textPrimary)

            Spacer()
        }
        .padding(.top, 16)
    }

    // MARK: - Appearance Section
    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Aparência")
                .font(AppTypography.headline)
                .foregroundColor(.textSecondary)

            GlassCard {
                VStack(spacing: 0) {
                    settingsRow(
                        icon: "moon.fill",
                        title: "Modo Escuro",
                        gradient: AppGradients.primary
                    ) {
                        Toggle("", isOn: $isDarkMode)
                            .tint(.primaryStart)
                    }
                }
            }
        }
    }

    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preferências")
                .font(AppTypography.headline)
                .foregroundColor(.textSecondary)

            GlassCard {
                VStack(spacing: 0) {
                    settingsRow(
                        icon: "clock.fill",
                        title: "Formato de Tempo",
                        subtitle: useDecimalTime ? "Decimal (1.5h)" : "Padrão (1h 30m)",
                        gradient: AppGradients.secondary
                    ) {
                        Toggle("", isOn: $useDecimalTime)
                            .tint(.primaryStart)
                    }

                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 8)

                    settingsRow(
                        icon: "bell.fill",
                        title: "Notificações",
                        gradient: AppGradients.accent
                    ) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textSecondary)
                    }

                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 8)

                    settingsRow(
                        icon: "figure.run",
                        title: "Tipos de Treino",
                        gradient: AppGradients.success
                    ) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
    }

    // MARK: - About Section
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sobre")
                .font(AppTypography.headline)
                .foregroundColor(.textSecondary)

            GlassCard {
                VStack(spacing: 0) {
                    Button(action: { showingAbout = true }) {
                        settingsRow(
                            icon: "info.circle.fill",
                            title: "Sobre o FitDash",
                            gradient: AppGradients.primary
                        ) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.textSecondary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 8)

                    settingsRow(
                        icon: "star.fill",
                        title: "Avaliar App",
                        gradient: AppGradients.accent
                    ) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textSecondary)
                    }

                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 8)

                    settingsRow(
                        icon: "envelope.fill",
                        title: "Feedback",
                        gradient: AppGradients.secondary
                    ) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
    }

    // MARK: - Settings Row
    private func settingsRow<Trailing: View>(
        icon: String,
        title: String,
        subtitle: String? = nil,
        gradient: LinearGradient,
        @ViewBuilder trailing: () -> Trailing
    ) -> some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(gradient.opacity(0.2))
                    .frame(width: 36, height: 36)

                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(gradient)
            }

            // Title and subtitle
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTypography.body)
                    .foregroundColor(.textPrimary)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(AppTypography.caption)
                        .foregroundColor(.textSecondary)
                }
            }

            Spacer()

            trailing()
        }
    }

    // MARK: - App Info
    private var appInfoView: some View {
        VStack(spacing: 8) {
            Text("FitDash v1.0.0")
                .font(AppTypography.caption)
                .foregroundColor(.textSecondary)

            Text("Feito com ❤️ para atletas")
                .font(AppTypography.caption2)
                .foregroundColor(.textSecondary.opacity(0.7))
        }
        .padding(.top, 24)
    }
}

// MARK: - About View
struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack(spacing: 32) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()

                // App icon placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(AppGradients.primary)
                        .frame(width: 100, height: 100)

                    Image(systemName: "figure.run")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                }

                // App name
                VStack(spacing: 8) {
                    Text("FitDash")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppGradients.primary)

                    Text("Seu companheiro de fitness")
                        .font(AppTypography.subheadline)
                        .foregroundColor(.textSecondary)
                }

                // Features
                VStack(alignment: .leading, spacing: 16) {
                    featureRow(icon: "chart.bar.fill", text: "Acompanhe seus treinos")
                    featureRow(icon: "flame.fill", text: "Monitore calorias queimadas")
                    featureRow(icon: "trophy.fill", text: "Alcance seus objetivos")
                }
                .padding(.horizontal, 40)

                Spacer()

                // Version
                Text("Versão 1.0.0")
                    .font(AppTypography.caption)
                    .foregroundColor(.textSecondary)
            }
            .padding()
        }
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(AppGradients.primary)
                .frame(width: 24)

            Text(text)
                .font(AppTypography.body)
                .foregroundColor(.textPrimary)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}

#Preview("About") {
    AboutView()
        .preferredColorScheme(.dark)
}
