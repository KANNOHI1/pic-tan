import SwiftUI
import PicTanCore

/// A single flashcard that flips to reveal the answer.
/// In image modes a large emoji is shown as the "picture".
struct CardView: View {

    let card: VocabularyCard
    let mode: StudyMode
    let isRevealed: Bool
    let onTap: () -> Void

    private var answer: String { mode.answer(for: card) }

    // Flip angle: 0 = question side, 180 = answer side
    private var flipDegrees: Double { isRevealed ? 180 : 0 }

    var body: some View {
        ZStack {
            questionFace
                .opacity(isRevealed ? 0 : 1)

            answerFace
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .opacity(isRevealed ? 1 : 0)
        }
        .rotation3DEffect(.degrees(flipDegrees), axis: (x: 0, y: 1, z: 0))
        .animation(.spring(duration: 0.45), value: isRevealed)
        .onTapGesture(perform: onTap)
    }

    // MARK: – Question face

    private var questionFace: some View {
        cardBase(color: Color(red: 0.98, green: 0.95, blue: 0.88))
            .overlay(
                Group {
                    if mode.isImageMode {
                        // Large emoji as picture
                        VStack(spacing: 8) {
                            Text(card.emoji)
                                .font(.system(size: 130))
                            Text("なんていう？")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(Color(red: 0.55, green: 0.45, blue: 0.35))
                        }
                    } else {
                        VStack(spacing: 12) {
                            Text(mode.prompt(for: card))
                                .font(.system(size: 52, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .padding(.horizontal, 16)
                            Text("タップしてみよう")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(Color(red: 0.55, green: 0.45, blue: 0.35))
                        }
                    }
                }
            )
    }

    // MARK: – Answer face

    private var answerFace: some View {
        cardBase(color: Color(red: 0.88, green: 0.96, blue: 0.92))
            .overlay(
                VStack(spacing: 14) {
                    Text("✨")
                        .font(.system(size: 28))
                    Text(answer)
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 16)
                }
            )
    }

    // MARK: – Shared card base

    private func cardBase(color: Color) -> some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .strokeBorder(Color(red: 0.80, green: 0.72, blue: 0.60), lineWidth: 2.5)
            )
            .frame(height: 280)
            .shadow(color: .black.opacity(0.10), radius: 10, y: 5)
    }
}
