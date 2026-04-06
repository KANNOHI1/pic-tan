import Foundation

/// A vocabulary card whose friendship score has reached the move-in threshold.
///
/// Once a card becomes a resident it is permanently part of the town,
/// even if future sessions lower the friendship score (scores never decrease).
public struct TownResident: Codable, Equatable, Identifiable {
    public var id: String { cardID }

    public let cardID: String
    public let cardEmoji: String
    public let wordJA: String
    public let wordEN: String
    public let friendshipScore: Int
    public let movedInAt: Date

    public init(
        cardID: String,
        cardEmoji: String,
        wordJA: String,
        wordEN: String,
        friendshipScore: Int,
        movedInAt: Date = Date()
    ) {
        self.cardID = cardID
        self.cardEmoji = cardEmoji
        self.wordJA = wordJA
        self.wordEN = wordEN
        self.friendshipScore = friendshipScore
        self.movedInAt = movedInAt
    }
}
