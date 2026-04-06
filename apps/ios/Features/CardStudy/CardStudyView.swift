import SwiftUI
import PicTanCore

/// Mission play screen.
struct CardStudyView: View {

    @StateObject private var vm: CardStudyViewModel

    let themeEmoji: String
    let onSessionComplete: ((Int, Int, [String]) -> Void)?
    let onBackToHome: (() -> Void)?

    init(
        cards: [VocabularyCard],
        initialMode: StudyMode = .pictogramToEn,
        themeEmoji: String = "🐾",
        onSessionComplete: ((Int, Int, [String]) -> Void)? = nil,
        onBackToHome: (() -> Void)? = nil
    ) {
        _vm = StateObject(wrappedValue: CardStudyViewModel(cards: cards, mode: initialMode))
        self.themeEmoji = themeEmoji
        self.onSessionComplete = onSessionComplete
        self.onBackToHome = onBackToHome
    }

    var body: some View {
        VStack(spacing: 0) {
            missionHeader
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 6)

            modePicker
                .padding(.horizontal, 16)
                .padding(.bottom, 6)

            progressSection
                .padding(.horizontal, 20)

            MascotView(reaction: vm.mascotReaction)
                .padding(.top, 8)
                .padding(.horizontal, 20)

            Spacer()

            if vm.isSessionComplete {
                SessionCompleteView(
                    correctCount: vm.correctCount,
                    totalCount: vm.totalCount,
                    hardWords: vm.hardWords,
                    themeEmoji: themeEmoji,
                    onRestart: vm.restart,
                    onBackToHome: {
                        onSessionComplete?(vm.correctCount, vm.totalCount, vm.hardWords)
                        onBackToHome?()
                    }
                )
            } else {
                studyContent
            }

            Spacer()
        }
        .background(Color(red: 0.99, green: 0.97, blue: 0.93).ignoresSafeArea())
    }

    // MARK: – Mission header

    private var missionHeader: some View {
        HStack {
            Button {
                onSessionComplete?(vm.correctCount, vm.totalCount, vm.hardWords)
                onBackToHome?()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("もどる")
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
            }
            Spacer()
            Text("\(themeEmoji) ミッション")
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
            Spacer()
            Color.clear.frame(width: 60, height: 20)
        }
    }

    // MARK: – Mode picker

    private var modePicker: some View {
        Picker("モード", selection: Binding(
            get: { vm.session.mode },
            set: { vm.changeMode($0) }
        )) {
            Text("絵→EN").tag(StudyMode.pictogramToEn)
            Text("絵→JA").tag(StudyMode.pictogramToJa)
            Text("EN→JA").tag(StudyMode.enToJa)
            Text("JA→EN").tag(StudyMode.jaToEn)
        }
        .pickerStyle(.segmented)
    }

    // MARK: – Progress

    private var progressSection: some View {
        VStack(spacing: 4) {
            HStack {
                Text("\(vm.session.currentIndex) / \(vm.totalCount)枚")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondary)
                Spacer()
                let remaining = vm.totalCount - vm.session.currentIndex
                Text(remaining <= 0 ? "完了！" : "あと\(remaining)枚")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.25, green: 0.52, blue: 0.35))
            }
            ProgressView(value: vm.progress)
                .tint(Color(red: 0.40, green: 0.70, blue: 0.55))
        }
        .padding(.top, 4)
    }

    // MARK: – Study content

    @ViewBuilder
    private var studyContent: some View {
        if let card = vm.currentCard {
            VStack(spacing: 16) {
                CardView(
                    card: card,
                    mode: vm.session.mode,
                    isRevealed: vm.isAnswerRevealed,
                    onTap: vm.revealAnswer
                )
                .padding(.horizontal, 20)

                if vm.isAnswerRevealed {
                    ratingButtons
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    Text("カードをタップしよう！")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            .animation(.easeOut(duration: 0.20), value: vm.isAnswerRevealed)
        }
    }

    // MARK: – Rating buttons

    private var ratingButtons: some View {
        HStack(spacing: 8) {
            ratingButton(.unknown, emoji: "😵", label: "わからない", color: Color(red: 0.85, green: 0.33, blue: 0.33))
            ratingButton(.hard,    emoji: "😓", label: "むずかしい", color: Color(red: 0.85, green: 0.53, blue: 0.18))
            ratingButton(.ok,      emoji: "😊", label: "なんとか",   color: Color(red: 0.27, green: 0.48, blue: 0.82))
            ratingButton(.perfect, emoji: "🌟", label: "知ってた！", color: Color(red: 0.25, green: 0.62, blue: 0.40))
        }
        .padding(.horizontal, 16)
    }

    private func ratingButton(_ rating: StudyRating, emoji: String, label: String, color: Color) -> some View {
        Button { vm.rate(rating) } label: {
            VStack(spacing: 4) {
                Text(emoji).font(.system(size: 22))
                Text(label)
                    .font(.system(size: 11, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(color, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
