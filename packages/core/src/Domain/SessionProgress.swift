import Foundation

/// Tracks progress within a single study session.
///
/// A session targets 8 cards in ~3 minutes (design spec §4).
public struct SessionProgress: Equatable {

    /// Default cards per session (design spec: 8 fixed).
    public static let defaultTargetCardCount = 8
    /// Target session duration in minutes.
    public static let targetMinutes = 3

    public let totalCards: Int
    public let completedCards: Int
    public let startedAt: Date

    public init(
        totalCards: Int = defaultTargetCardCount,
        completedCards: Int = 0,
        startedAt: Date = Date()
    ) {
        self.totalCards = totalCards
        self.completedCards = completedCards
        self.startedAt = startedAt
    }

    public var remainingCards: Int { totalCards - completedCards }

    public var isComplete: Bool { completedCards >= totalCards }

    /// 0.0 … 1.0 fraction of cards completed.
    public var fractionComplete: Double {
        totalCards > 0 ? Double(completedCards) / Double(totalCards) : 0
    }

    /// Returns a new progress value advanced by one card.
    public func advancing() -> SessionProgress {
        SessionProgress(totalCards: totalCards, completedCards: completedCards + 1, startedAt: startedAt)
    }
}
