import SwiftUI

/// The three mascot reaction states surfaced in the UI.
enum MascotReaction {
    case idle       // waiting for user action
    case thinking   // answer revealed, user deciding
    case happy      // rated perfect or ok
    case struggling // rated hard or unknown
}

/// Emoji-based mascot character with bounce animation.
/// Uses a chick character 🐣 as the main mascot — no assets required,
/// copyright-free, universally kid-friendly.
struct MascotView: View {

    let reaction: MascotReaction

    @State private var bounce = false

    private var mascotEmoji: String {
        switch reaction {
        case .idle:       return "🐣"
        case .thinking:   return "🤔"
        case .happy:      return "🌟"
        case .struggling: return "💪"
        }
    }

    private var label: String {
        switch reaction {
        case .idle:       return "まってるよ"
        case .thinking:   return "かんがえて！"
        case .happy:      return "やったね！"
        case .struggling: return "だいじょうぶ！"
        }
    }

    private var bubbleColor: Color {
        switch reaction {
        case .idle:       return Color(red: 0.95, green: 0.90, blue: 0.80)
        case .thinking:   return Color(red: 0.95, green: 0.88, blue: 0.55).opacity(0.6)
        case .happy:      return Color(red: 0.70, green: 0.95, blue: 0.78).opacity(0.7)
        case .struggling: return Color(red: 0.95, green: 0.75, blue: 0.60).opacity(0.6)
        }
    }

    var body: some View {
        HStack(spacing: 10) {
            Text(mascotEmoji)
                .font(.system(size: 48))
                .scaleEffect(bounce ? 1.25 : 1.0)
                .animation(
                    .spring(response: 0.3, dampingFraction: 0.4).repeatCount(2, autoreverses: true),
                    value: bounce
                )

            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.35, green: 0.25, blue: 0.15))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(bubbleColor, in: Capsule())
        }
        .onChange(of: reaction) { _, _ in
            bounce = false
            Task {
                try? await Task.sleep(for: .milliseconds(50))
                bounce = true
            }
        }
    }
}
