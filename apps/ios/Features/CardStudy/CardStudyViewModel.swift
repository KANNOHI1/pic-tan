import Foundation
import PicTanCore

@MainActor
final class CardStudyViewModel: ObservableObject {

    @Published var session: StudySessionState
    @Published var isAnswerRevealed = false
    @Published var mascotReaction: MascotReaction = .idle
    @Published var isSessionComplete = false
    @Published var correctCount = 0
    @Published var hardWords: [String] = []

    init(cards: [VocabularyCard], mode: StudyMode = .pictogramToEn) {
        self.session = StudySessionState(mode: mode, queue: cards)
    }

    var currentCard: VocabularyCard? { session.currentCard }
    var totalCount: Int { session.queue.count }
    var progress: Double {
        guard !session.queue.isEmpty else { return 1 }
        return Double(session.currentIndex) / Double(session.queue.count)
    }

    func revealAnswer() {
        guard !isAnswerRevealed else { return }
        isAnswerRevealed = true
        mascotReaction = .thinking
    }

    func rate(_ rating: StudyRating) {
        if rating == .perfect || rating == .ok {
            correctCount += 1
            mascotReaction = .happy
        } else {
            mascotReaction = .struggling
            if let card = currentCard {
                hardWords.append(card.wordJA)
            }
        }
        session.rateCurrentCard(rating)
        Task {
            try? await Task.sleep(for: .milliseconds(550))
            isAnswerRevealed = false
            if session.currentCard == nil {
                isSessionComplete = true
            } else {
                mascotReaction = .idle
            }
        }
    }

    func changeMode(_ mode: StudyMode) {
        session = StudySessionState(mode: mode, queue: session.queue)
        isAnswerRevealed = false
        mascotReaction = .idle
        isSessionComplete = false
        correctCount = 0
        hardWords = []
    }

    func restart() {
        changeMode(session.mode)
    }
}
