import Foundation

public struct StudySessionState: Equatable {
    public let mode: StudyMode
    public let queue: [VocabularyCard]
    public private(set) var currentIndex: Int
    public private(set) var records: [StudyRecord]
    /// Current 3-stage reveal position for the active card.
    public private(set) var revealStage: CardRevealStage
    /// Session-level progress (cards completed, time started).
    public private(set) var progress: SessionProgress

    public init(
        mode: StudyMode,
        queue: [VocabularyCard],
        currentIndex: Int = 0,
        records: [StudyRecord] = []
    ) {
        self.mode = mode
        self.queue = queue
        self.currentIndex = currentIndex
        self.records = records
        self.revealStage = .imageOnly
        self.progress = SessionProgress(totalCards: queue.count)
    }

    public var currentCard: VocabularyCard? {
        guard queue.indices.contains(currentIndex) else { return nil }
        return queue[currentIndex]
    }

    /// Advance the card's reveal stage by one tap.
    ///
    /// - Returns: `true` when the card is now fully revealed and ready to rate.
    @discardableResult
    public mutating func advanceTap() -> Bool {
        guard let next = revealStage.next() else { return revealStage.isRatable }
        revealStage = next
        return revealStage.isRatable
    }

    /// Rate the current card with a 4-level rating.
    /// Resets the reveal stage and advances session progress.
    public mutating func rateCurrentCard(
        _ rating: StudyRating,
        now: Date = Date(),
        calendar: Calendar = .current
    ) {
        guard let card = currentCard else { return }
        let nextDate = ReviewQueueSeeder.nextReviewDate(from: now, rating: rating, calendar: calendar)
        let record = StudyRecord(cardID: card.id, rating: rating, reviewedAt: now, nextReviewAt: nextDate)
        records.append(record)
        currentIndex += 1
        revealStage = .imageOnly
        progress = progress.advancing()
    }

    /// Convenience overload for the 2-button design ("しってた！" / "むずかしい").
    ///
    /// Maps `knew: true` → `.ok`, `knew: false` → `.hard`.
    public mutating func rateCurrentCard(
        knew: Bool,
        now: Date = Date(),
        calendar: Calendar = .current
    ) {
        rateCurrentCard(knew ? .ok : .hard, now: now, calendar: calendar)
    }
}
