import Foundation

/// The full state of the player's town: friendship scores, residents, and progression level.
///
/// `TownState` is a pure value type — mutation returns a new value.
/// Persistence is handled by `TownStore`.
///
/// Level formula (from web app.js `getTownImageLevel`):
///   `level = min(residents.count + 1, maxLevel)`
///
/// Asset names match the files in `apps/ios/Resources/Images/town/`.
public struct TownState: Equatable {

    // MARK: - Constants

    /// Friendship score required for a card to move into town.
    public static let moveInThreshold = 10
    /// Maximum town level (matches the 12 town_level images).
    public static let maxLevel = 12

    /// Resident count thresholds at which each reward image is unlocked.
    public static let rewardMilestones: [(residentCount: Int, imageName: String)] = [
        (3,  "town_reward_built_tree"),
        (6,  "town_reward_new_house"),
        (9,  "town_reward_open_bakery"),
        (12, "town_reward_fireworks"),
    ]

    // MARK: - State

    /// Friendship score per card ID (never decreases).
    public let friendships: [String: Int]
    /// Cards that have reached `moveInThreshold` and now live in town.
    public let residents: [TownResident]

    // MARK: - Derived

    /// Current town level (1–12). Image name: `town_level_XX`.
    public var level: Int {
        min(residents.count + 1, TownState.maxLevel)
    }

    /// Image asset name for the current town level (no extension).
    public var townImageName: String {
        String(format: "town_level_%02d", level)
    }

    /// Image asset names for all reward stamps unlocked so far.
    public var unlockedRewardImageNames: [String] {
        TownState.rewardMilestones
            .filter { residents.count >= $0.residentCount }
            .map(\.imageName)
    }

    /// Friendship score for a specific card, defaulting to 0.
    public func friendshipScore(for cardID: String) -> Int {
        friendships[cardID, default: 0]
    }

    // MARK: - Init

    public init(friendships: [String: Int] = [:], residents: [TownResident] = []) {
        self.friendships = friendships
        self.residents = residents
    }

    // MARK: - Mutation

    /// Return a new `TownState` after applying a study rating for one card.
    ///
    /// Friendship delta matches web `app.js addFriendship`:
    ///   - review + knew  → +3
    ///   - review + missed → +1
    ///   - new    + knew  → +2
    ///   - new    + missed → +1
    ///
    /// If the new score crosses `moveInThreshold` the card becomes a resident.
    ///
    /// - Parameters:
    ///   - card: The card that was just studied.
    ///   - knew: Whether the learner answered correctly.
    ///   - isReview: Whether this card was a spaced-repetition review (vs. seen for first time).
    public func applying(
        card: VocabularyCard,
        knew: Bool,
        isReview: Bool,
        now: Date = Date()
    ) -> TownState {
        let delta: Int
        switch (isReview, knew) {
        case (true,  true):  delta = 3
        case (true,  false): delta = 1
        case (false, true):  delta = 2
        case (false, false): delta = 1
        }

        var newFriendships = friendships
        let oldScore = newFriendships[card.id, default: 0]
        let newScore = oldScore + delta
        newFriendships[card.id] = newScore

        var newResidents = residents
        let alreadyResident = residents.contains { $0.cardID == card.id }
        if newScore >= TownState.moveInThreshold && !alreadyResident {
            newResidents.append(TownResident(
                cardID: card.id,
                cardEmoji: card.emoji,
                wordJA: card.wordJA,
                wordEN: card.wordEN,
                friendshipScore: newScore,
                movedInAt: now
            ))
        }

        return TownState(friendships: newFriendships, residents: newResidents)
    }

    /// Whether this rating caused a new move-in (for triggering celebration UI).
    public func newResident(after applying: TownState) -> TownResident? {
        applying.residents.first { r in !residents.contains { $0.cardID == r.cardID } }
    }
}
