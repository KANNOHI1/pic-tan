import SwiftUI
import PicTanCore

/// Home screen: 3-minute daily mission selection.
/// Shows themes as mission cards, today's progress, and a parent trust panel.
struct HomeView: View {

    @State private var selectedTheme: ContentLoader.ThemeInfo?
    @State private var cards: [VocabularyCard] = []
    @State private var loadError: String?
    @State private var completedThemeIDs: Set<String> = []
    @State private var sessionLog: [SessionLogEntry] = []
    @State private var showParentGate = false
    @State private var heroMascot = "🐣"

    // Parent gate state
    @State private var gateAnswer = ""
    @State private var gateExpected = ""
    @State private var gateQuestion = ""
    @State private var gateWrong = false
    @State private var showParentPanel = false

    // Persistent stores
    private let streakStore    = StreakStore()
    private let parentSettings = ParentSettings()
    private let townStore      = TownStore()

    // Loaded data
    @State private var streakInfo: StreakStore.StreakInfo = .empty
    @State private var townState: TownState = TownState()
    @State private var selectedAgeBand: AgeBand = .preschool

    struct SessionLogEntry {
        let theme: ContentLoader.ThemeInfo
        let correct: Int
        let total: Int
        let hardWords: [String]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    heroSection
                    streakBanner
                    missionProgress
                    themeSection
                    trustBar
                    if showParentGate && !showParentPanel { parentGateSection }
                    if showParentPanel { parentPanel }
                }
            }
            .background(Color(red: 0.99, green: 0.97, blue: 0.93).ignoresSafeArea())
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: Binding(
                get: { selectedTheme != nil && !cards.isEmpty },
                set: { if !$0 { selectedTheme = nil; cards = [] } }
            )) {
                if let theme = selectedTheme {
                    CardStudyView(
                        cards: cards,
                        themeEmoji: theme.emoji,
                        onSessionComplete: { correct, total, hard in
                            completedThemeIDs.insert(theme.id)
                            sessionLog.append(SessionLogEntry(
                                theme: theme, correct: correct,
                                total: total, hardWords: hard))
                            streakInfo = streakStore.recordToday()
                        },
                        onBackToHome: { selectedTheme = nil; cards = [] }
                    )
                }
            }
        }
        .onAppear {
            startHeroAnimation()
            streakInfo = streakStore.load()
            townState = townStore.load()
            selectedAgeBand = parentSettings.ageBand
        }
    }

    // MARK: – Hero

    private var heroSection: some View {
        VStack(spacing: 8) {
            Text(heroMascot)
                .font(.system(size: 62))
                .animation(.spring(response: 0.4, dampingFraction: 0.5), value: heroMascot)
            Text("ピクたん")
                .font(.system(size: 32, weight: .black, design: .rounded))
                .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
            Text("毎日3分 えいごカード")
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
            Text("今日もやってみよう！")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.20, green: 0.18, blue: 0.14))
        }
        .padding(.top, 40)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [
                Color(red: 1.0, green: 0.97, blue: 0.88),
                Color(red: 0.89, green: 0.96, blue: 0.91)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }

    // MARK: – Streak banner

    @ViewBuilder
    private var streakBanner: some View {
        if streakInfo.count >= 2 {
            let icon = streakInfo.count >= 7 ? "🔥" : streakInfo.count >= 3 ? "🌟" : "✨"
            HStack(spacing: 6) {
                Text(icon)
                    .font(.system(size: 20))
                Text("\(streakInfo.count)日れんぞく！")
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundStyle(Color(red: 0.80, green: 0.45, blue: 0.10))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color(red: 1.0, green: 0.95, blue: 0.82))
        }
    }

    // MARK: – Mission progress dots

    private var missionProgress: some View {
        HStack(spacing: 10) {
            Text("今日のミッション")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
            HStack(spacing: 8) {
                ForEach(ContentLoader.availableThemes, id: \.id) { theme in
                    Text(completedThemeIDs.contains(theme.id) ? "✅" : "⬜")
                        .font(.system(size: 18))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 1.0, green: 0.97, blue: 0.92))
    }

    // MARK: – Theme cards

    private var themeSection: some View {
        VStack(spacing: 12) {
            ForEach(ContentLoader.availableThemes, id: \.id) { theme in
                themeCard(theme)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private func themeCard(_ theme: ContentLoader.ThemeInfo) -> some View {
        let done = completedThemeIDs.contains(theme.id)
        return Button { loadTheme(theme) } label: {
            HStack(spacing: 16) {
                Text(theme.emoji)
                    .font(.system(size: 40))
                    .frame(width: 56)

                VStack(alignment: .leading, spacing: 3) {
                    Text(theme.nameJA)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundStyle(Color(red: 0.18, green: 0.14, blue: 0.10))
                    Text(theme.nameEN)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if done {
                    Text("✅ クリア！")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                } else {
                    Text("スタート →")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(done
                ? Color(red: 0.88, green: 0.96, blue: 0.90)
                : Color.white.opacity(0.90),
                in: RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(done
                        ? Color(red: 0.64, green: 0.83, blue: 0.71)
                        : Color(red: 0.84, green: 0.78, blue: 0.70),
                        lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
        }
        .buttonStyle(.plain)
    }

    // MARK: – Trust bar

    private var trustBar: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ForEach(["🔒 広告なし", "🏠 オフライン", "🤝 個人情報なし"], id: \.self) { badge in
                    Text(badge)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.8), in: Capsule())
                        .overlay(Capsule().strokeBorder(Color(red: 0.84, green: 0.78, blue: 0.70), lineWidth: 1))
                }
            }
            Button {
                withAnimation(.easeOut(duration: 0.2)) {
                    if showParentPanel {
                        showParentPanel = false
                        showParentGate = false
                    } else if showParentGate {
                        showParentGate = false
                    } else {
                        generateGate()
                        showParentGate = true
                    }
                }
            } label: {
                let isOpen = showParentPanel || showParentGate
                Text("保護者の方へ " + (isOpen ? "▴" : "▾"))
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.97, green: 0.94, blue: 0.92))
    }

    // MARK: – Parent gate (trust layer)

    private var parentGateSection: some View {
        VStack(spacing: 14) {
            Text("🔢 保護者の方だけ入れます")
                .font(.system(size: 14, weight: .black, design: .rounded))
                .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))

            Text(gateQuestion)
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundStyle(Color(red: 0.18, green: 0.14, blue: 0.10))

            HStack(spacing: 10) {
                TextField("こたえ", text: $gateAnswer)
                    .keyboardType(.numberPad)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
                    .padding(.vertical, 10)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(gateWrong
                                ? Color.red.opacity(0.7)
                                : Color(red: 0.84, green: 0.78, blue: 0.70),
                                lineWidth: 2)
                    )

                Button("かくにん") {
                    verifyGate()
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(Color(red: 0.25, green: 0.62, blue: 0.40), in: RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.white)
            }

            if gateWrong {
                Text("もう一度どうぞ")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(.red)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.95, green: 0.97, blue: 1.0))
    }

    // MARK: – Parent panel (full)

    private var parentPanel: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            Text("保護者の方へ")
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))

            // Streak
            if streakInfo.count > 0 {
                HStack(spacing: 8) {
                    Text(streakInfo.count >= 7 ? "🔥" : streakInfo.count >= 3 ? "🌟" : "✨")
                        .font(.system(size: 22))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(streakInfo.count)日れんぞく学習中！")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundStyle(Color(red: 0.80, green: 0.45, blue: 0.10))
                        Text("毎日続けることで記憶が定着します")
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(12)
                .background(Color(red: 1.0, green: 0.96, blue: 0.85), in: RoundedRectangle(cornerRadius: 12))
            }

            // Town progress
            if !townState.residents.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("🏘️ まちの成長")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                    Text("レベル \(townState.level)  ／  住民 \(townState.residents.count) 匹")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.secondary)
                    let emojis = townState.residents.prefix(10).map(\.cardEmoji).joined()
                    Text(emojis + (townState.residents.count > 10 ? "…" : ""))
                        .font(.system(size: 22))
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 0.90, green: 0.97, blue: 0.93), in: RoundedRectangle(cornerRadius: 12))
            }

            // Today's sessions
            if !sessionLog.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("📝 今日の学習記録")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                    ForEach(sessionLog, id: \.theme.id) { log in
                        HStack {
                            Text("\(log.theme.emoji) \(log.theme.nameJA)")
                            Spacer()
                            Text("\(log.correct)/\(log.total)語 正解")
                                .foregroundStyle(.secondary)
                        }
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                    Text("※エビングハウス忘却曲線に基づき、\n　最適なタイミングで復習を出します")
                        .font(.system(size: 11, design: .rounded))
                        .foregroundStyle(.secondary)
                        .padding(.top, 2)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 0.94, green: 0.98, blue: 0.95), in: RoundedRectangle(cornerRadius: 12))
            }

            // Age-band picker
            VStack(alignment: .leading, spacing: 8) {
                Text("👶 お子さまの年齢")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                HStack(spacing: 8) {
                    ForEach(AgeBand.allCases, id: \.rawValue) { band in
                        let selected = selectedAgeBand == band
                        Button {
                            selectedAgeBand = band
                            parentSettings.ageBand = band
                        } label: {
                            Text(band.displayLabel)
                                .font(.system(size: 12, weight: selected ? .black : .medium, design: .rounded))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    selected ? Color(red: 0.25, green: 0.62, blue: 0.40) : Color.white.opacity(0.8),
                                    in: Capsule()
                                )
                                .foregroundStyle(selected ? .white : Color(red: 0.18, green: 0.14, blue: 0.10))
                                .overlay(Capsule().strokeBorder(
                                    selected ? Color.clear : Color(red: 0.84, green: 0.78, blue: 0.70),
                                    lineWidth: 1.5))
                        }
                        .buttonStyle(.plain)
                    }
                }
                Text(selectedAgeBand.difficultyDescription)
                    .font(.system(size: 11, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.97, green: 0.96, blue: 1.0), in: RoundedRectangle(cornerRadius: 12))

            // Safety badges
            VStack(alignment: .leading, spacing: 6) {
                Text("🛡️ 安全性")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                ForEach([
                    "🔒 広告・外部リンクは一切ありません",
                    "🏠 インターネット接続は不要です",
                    "🤝 個人情報・位置情報を収集しません",
                    "⏱️ 1セッション約3分を目安に設計",
                    "🌍 日本語・英語を同時に学べます"
                ], id: \.self) { item in
                    Text(item)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.18, green: 0.14, blue: 0.10))
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.94, green: 0.98, blue: 0.95), in: RoundedRectangle(cornerRadius: 12))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.94, green: 0.98, blue: 0.95))
    }

    // MARK: – Helpers

    private func loadTheme(_ theme: ContentLoader.ThemeInfo) {
        loadError = nil
        do {
            let allCards = try ContentLoader.loadCards(theme: theme.id, locale: "ja-JP")
            cards = parentSettings.ageBand.filter(allCards)
            selectedTheme = theme
        } catch {
            loadError = error.localizedDescription
        }
    }

    private func startHeroAnimation() {
        let expressions = ["🐣","🐣","🐣","😄","🐣","🌟","🐣","🐣"]
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true) { _ in
            i += 1
            heroMascot = expressions[i % expressions.count]
        }
    }

    private func generateGate() {
        let a = Int.random(in: 2...9)
        let b = Int.random(in: 2...9)
        gateQuestion = "\(a)  ＋  \(b)  ＝  ？"
        gateExpected = "\(a + b)"
        gateAnswer = ""
        gateWrong = false
    }

    private func verifyGate() {
        if gateAnswer.trimmingCharacters(in: .whitespaces) == gateExpected {
            withAnimation(.easeOut(duration: 0.2)) {
                showParentGate = false
                showParentPanel = true
                townState = townStore.load()
                streakInfo = streakStore.load()
                selectedAgeBand = parentSettings.ageBand
            }
        } else {
            gateWrong = true
            generateGate()
            gateAnswer = ""
        }
    }
}

// MARK: – AgeBand display helpers

private extension AgeBand {
    var displayLabel: String {
        switch self {
        case .toddler:     return "2〜3歳"
        case .preschool:   return "4〜5歳"
        case .earlyReader: return "6歳以上"
        }
    }

    var difficultyDescription: String {
        switch self {
        case .toddler:     return "基本的な単語のみ（難易度1）"
        case .preschool:   return "標準語彙（難易度1〜2）"
        case .earlyReader: return "すべての単語（難易度1〜3）"
        }
    }
}
