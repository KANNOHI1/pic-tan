import Foundation

public enum ReviewQueueSeeder {
    public static func nextReviewDate(
        from date: Date,
        rating: StudyRating,
        calendar: Calendar = .current
    ) -> Date {
        let dayOffset = rating.intervalDays
        return calendar.date(byAdding: .day, value: dayOffset, to: date) ?? date
    }

    public static func seedQueue(
        cards: [VocabularyCard],
        dueAt targetDate: Date,
        records: [StudyRecord]
    ) -> [VocabularyCard] {
        let dueIDs = Set(records.filter { $0.nextReviewAt <= targetDate }.map { $0.cardID })
        return cards.filter { dueIDs.contains($0.id) }
    }

    /// Build a session queue matching the web preview session-builder logic.
    ///
    /// Priority order:
    ///   1. Due cards (`nextReviewAt ≤ targetDate`), up to `maxDueCards`
    ///   2. Fresh cards (no review record at all), filling remaining slots
    ///   3. Seen-but-not-due cards, filling any remaining slots
    ///
    /// The result is shuffled (Fisher-Yates) and trimmed to `targetCount`.
    public static func buildSession(
        cards: [VocabularyCard],
        records: [StudyRecord],
        targetDate: Date = Date(),
        targetCount: Int = SessionProgress.defaultTargetCardCount,
        maxDueCards: Int = 3
    ) -> [VocabularyCard] {
        // Latest nextReviewAt per card (a card may be reviewed multiple times)
        var latestReview: [String: Date] = [:]
        for record in records {
            if let existing = latestReview[record.cardID] {
                if record.nextReviewAt > existing { latestReview[record.cardID] = record.nextReviewAt }
            } else {
                latestReview[record.cardID] = record.nextReviewAt
            }
        }

        let due   = cards.filter { latestReview[$0.id] != nil && latestReview[$0.id]! <= targetDate }
        let fresh = cards.filter { latestReview[$0.id] == nil }
        let seen  = cards.filter { latestReview[$0.id] != nil && latestReview[$0.id]! > targetDate }

        var session: [VocabularyCard] = []
        session.append(contentsOf: due.prefix(maxDueCards))
        session.append(contentsOf: fresh.prefix(targetCount - session.count))
        session.append(contentsOf: seen.prefix(targetCount - session.count))

        // Fisher-Yates shuffle
        for i in stride(from: session.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            session.swapAt(i, j)
        }

        return Array(session.prefix(targetCount))
    }
}
