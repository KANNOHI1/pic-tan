import SwiftUI

/// Mission complete screen with celebration, parent summary, and replay motivation.
struct SessionCompleteView: View {

    let correctCount: Int
    let totalCount: Int
    let hardWords: [String]
    let themeEmoji: String
    let onRestart: () -> Void
    let onBackToHome: () -> Void

    @State private var starsAppeared = false
    @State private var mascotBounce = false
    @State private var showParentSummary = false

    private var starCount: Int {
        let ratio = totalCount == 0 ? 0.0 : Double(correctCount) / Double(totalCount)
        return ratio >= 0.8 ? 3 : ratio >= 0.5 ? 2 : 1
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Stars
                HStack(spacing: 14) {
                    ForEach(0..<3, id: \.self) { i in
                        Text("⭐")
                            .font(.system(size: 48))
                            .scaleEffect(starsAppeared && i < starCount ? 1.0 : 0.1)
                            .opacity(starsAppeared && i < starCount ? 1.0 : 0.18)
                            .animation(
                                .spring(response: 0.5, dampingFraction: 0.5).delay(Double(i) * 0.2),
                                value: starsAppeared
                            )
                    }
                }
                .padding(.top, 12)

                // Mascot
                Text("🐣")
                    .font(.system(size: 72))
                    .scaleEffect(mascotBounce ? 1.25 : 1.0)
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.4).repeatCount(3, autoreverses: true),
                        value: mascotBounce
                    )

                // Title & score
                VStack(spacing: 6) {
                    Text("ミッションクリア！")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                    Text("\(correctCount) / \(totalCount) 語 正解")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                }

                // Action buttons
                VStack(spacing: 10) {
                    Button(action: onRestart) {
                        Text("もう一度！")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.25, green: 0.62, blue: 0.40), in: RoundedRectangle(cornerRadius: 20))
                            .foregroundStyle(.white)
                    }

                    Button(action: onBackToHome) {
                        Label("テーマをえらぶ", systemImage: "house.fill")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.88, green: 0.96, blue: 0.90), in: RoundedRectangle(cornerRadius: 20))
                            .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                    }
                }
                .padding(.horizontal, 24)

                // Parent summary (collapsible)
                parentSummarySection
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
        .onAppear {
            Task {
                try? await Task.sleep(for: .milliseconds(150))
                starsAppeared = true
                mascotBounce = true
            }
        }
    }

    // MARK: – Parent summary

    private var parentSummarySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeOut(duration: 0.2)) { showParentSummary.toggle() }
            } label: {
                HStack {
                    Text("保護者の方へ — 今回の学習記録")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                    Spacer()
                    Image(systemName: showParentSummary ? "chevron.up" : "chevron.down")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
                }
                .padding(14)
                .background(Color(red: 0.90, green: 0.97, blue: 0.93), in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)

            if showParentSummary {
                VStack(alignment: .leading, spacing: 8) {
                    Text("✅ 正解: \(correctCount) / \(totalCount) 語")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                    if hardWords.isEmpty {
                        Text("むずかしい語はありませんでした 🎉")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                    } else {
                        Text("むずかしかった語: \(hardWords.joined(separator: "・"))")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                    Divider()
                    HStack(spacing: 12) {
                        Label("広告なし", systemImage: "lock.fill")
                        Label("オフライン", systemImage: "house.fill")
                        Label("個人情報なし", systemImage: "hand.raised.fill")
                    }
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color(red: 0.94, green: 0.98, blue: 0.95), in: RoundedRectangle(cornerRadius: 14))
                .padding(.top, 4)
            }
        }
    }
}
