import XCTest
@testable import PicTanCore

final class TownStateTests: XCTestCase {

    private let cat = VocabularyCard(
        id: "animal_cat", wordEN: "cat", wordJA: "ねこ",
        theme: "animals", difficulty: 1, emoji: "🐱", pictogramPrompt: "cat"
    )
    private let dog = VocabularyCard(
        id: "animal_dog", wordEN: "dog", wordJA: "いぬ",
        theme: "animals", difficulty: 1, emoji: "🐶", pictogramPrompt: "dog"
    )

    // MARK: - Level formula

    func testInitialLevelIsOne() {
        XCTAssertEqual(TownState().level, 1)
    }

    func testLevelEqualsResidentsPlusOne() {
        var town = TownState()
        // Add enough friendship to get 3 residents
        for card in [cat, dog, makeCard("bird")] {
            for _ in 0..<5 {
                town = town.applying(card: card, knew: true, isReview: true) // +3 each = 15 → resident
            }
        }
        XCTAssertEqual(town.residents.count, 3)
        XCTAssertEqual(town.level, 4) // min(3 + 1, 12)
    }

    func testMaxLevelCapsAtTwelve() {
        var town = TownState()
        // Force 12+ residents
        for i in 0..<15 {
            let card = makeCard("card\(i)")
            for _ in 0..<4 {
                town = town.applying(card: card, knew: true, isReview: true) // +3 each = 12 → resident
            }
        }
        XCTAssertGreaterThanOrEqual(town.residents.count, 12)
        XCTAssertEqual(town.level, 12)
    }

    // MARK: - Friendship delta

    func testFriendshipDeltaNewKnew() {
        let town = TownState().applying(card: cat, knew: true, isReview: false)
        XCTAssertEqual(town.friendshipScore(for: cat.id), 2)
    }

    func testFriendshipDeltaNewMissed() {
        let town = TownState().applying(card: cat, knew: false, isReview: false)
        XCTAssertEqual(town.friendshipScore(for: cat.id), 1)
    }

    func testFriendshipDeltaReviewKnew() {
        let town = TownState().applying(card: cat, knew: true, isReview: true)
        XCTAssertEqual(town.friendshipScore(for: cat.id), 3)
    }

    func testFriendshipDeltaReviewMissed() {
        let town = TownState().applying(card: cat, knew: false, isReview: true)
        XCTAssertEqual(town.friendshipScore(for: cat.id), 1)
    }

    func testFriendshipAccumulates() {
        var town = TownState()
        town = town.applying(card: cat, knew: true, isReview: false)   // +2 = 2
        town = town.applying(card: cat, knew: true, isReview: true)    // +3 = 5
        town = town.applying(card: cat, knew: false, isReview: false)  // +1 = 6
        XCTAssertEqual(town.friendshipScore(for: cat.id), 6)
    }

    // MARK: - Move-in

    func testMoveInAtThreshold() {
        var town = TownState()
        // Need 10 points: 3+3+3+1 = 10
        town = town.applying(card: cat, knew: true, isReview: true)  // 3
        town = town.applying(card: cat, knew: true, isReview: true)  // 6
        town = town.applying(card: cat, knew: true, isReview: true)  // 9
        XCTAssertEqual(town.residents.count, 0, "Not yet at threshold")
        town = town.applying(card: cat, knew: false, isReview: true) // 10
        XCTAssertEqual(town.residents.count, 1)
        XCTAssertEqual(town.residents.first?.cardID, cat.id)
        XCTAssertEqual(town.residents.first?.wordJA, "ねこ")
    }

    func testAlreadyResidentNotDuplicated() {
        var town = TownState()
        for _ in 0..<5 {
            town = town.applying(card: cat, knew: true, isReview: true) // +3 each = 15 → resident
        }
        XCTAssertEqual(town.residents.count, 1)
        // More sessions don't add duplicates
        town = town.applying(card: cat, knew: true, isReview: true)
        XCTAssertEqual(town.residents.count, 1)
    }

    // MARK: - Rewards

    func testNoRewardsInitially() {
        XCTAssertTrue(TownState().unlockedRewardImageNames.isEmpty)
    }

    func testFirstRewardAt3Residents() {
        var town = TownState()
        let cards = (0..<3).map { makeCard("c\($0)") }
        for card in cards {
            for _ in 0..<4 {
                town = town.applying(card: card, knew: true, isReview: true) // 12 pts → resident
            }
        }
        XCTAssertEqual(town.residents.count, 3)
        XCTAssertTrue(town.unlockedRewardImageNames.contains("town_reward_built_tree"))
    }

    func testAllFourRewardsAt12Residents() {
        var town = TownState()
        for i in 0..<12 {
            let card = makeCard("c\(i)")
            for _ in 0..<4 {
                town = town.applying(card: card, knew: true, isReview: true)
            }
        }
        XCTAssertEqual(town.unlockedRewardImageNames.count, 4)
    }

    // MARK: - Town image name

    func testTownImageNameFormat() {
        XCTAssertEqual(TownState().townImageName, "town_level_01")
    }

    // MARK: - New resident detection

    func testNewResidentDetection() {
        var town = TownState()
        for _ in 0..<3 {
            town = town.applying(card: cat, knew: true, isReview: true) // 9 pts
        }
        let updated = town.applying(card: cat, knew: false, isReview: true) // 10 → moves in
        let newcomer = town.newResident(after: updated)
        XCTAssertEqual(newcomer?.cardID, cat.id)
    }

    func testNoNewResidentWhenAlreadyMoveIn() {
        var town = TownState()
        for _ in 0..<4 {
            town = town.applying(card: cat, knew: true, isReview: true) // 12 → resident
        }
        let updated = town.applying(card: cat, knew: true, isReview: true)
        XCTAssertNil(town.newResident(after: updated))
    }
}

// MARK: - TownStore (UserDefaults persistence)

final class TownStoreTests: XCTestCase {

    private var suiteName: String!
    private var store: TownStore!

    override func setUp() {
        super.setUp()
        suiteName = "PicTanCoreTests_\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        store = TownStore(defaults: defaults)
    }

    override func tearDown() {
        store.reset()
        UserDefaults().removePersistentDomain(forName: suiteName)
        super.tearDown()
    }

    func testEmptyLoadReturnsEmptyState() {
        let state = store.load()
        XCTAssertTrue(state.friendships.isEmpty)
        XCTAssertTrue(state.residents.isEmpty)
    }

    func testSaveAndReload() {
        let card = makeCard("cat")
        store.applyRating(card: card, knew: true, isReview: true)  // +3
        store.applyRating(card: card, knew: true, isReview: true)  // +3
        store.applyRating(card: card, knew: true, isReview: true)  // +3
        store.applyRating(card: card, knew: true, isReview: false) // +2 = 11 → resident

        let reloaded = store.load()
        XCTAssertEqual(reloaded.friendshipScore(for: "cat"), 11)
        XCTAssertEqual(reloaded.residents.count, 1)
    }

    func testResetClearsAll() {
        let card = makeCard("cat")
        for _ in 0..<4 { store.applyRating(card: card, knew: true, isReview: true) }
        store.reset()
        let state = store.load()
        XCTAssertTrue(state.friendships.isEmpty)
        XCTAssertTrue(state.residents.isEmpty)
    }
}

// MARK: - Helpers

private func makeCard(_ id: String, difficulty: Int = 1) -> VocabularyCard {
    VocabularyCard(
        id: id, wordEN: id, wordJA: "\(id)JA",
        theme: "animals", difficulty: difficulty,
        emoji: "🐱", pictogramPrompt: "\(id) pictogram"
    )
}
