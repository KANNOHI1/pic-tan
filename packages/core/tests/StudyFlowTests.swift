import XCTest
@testable import PicTanCore

// MARK: - CardRevealStage

final class CardRevealStageTests: XCTestCase {

    func testThreeStageProgression() {
        let s0 = CardRevealStage.imageOnly
        XCTAssertFalse(s0.isRatable)

        let s1 = s0.next()
        XCTAssertEqual(s1, .englishRevealed)
        XCTAssertFalse(s1!.isRatable)

        let s2 = s1!.next()
        XCTAssertEqual(s2, .answerRevealed)
        XCTAssertTrue(s2!.isRatable)

        XCTAssertNil(s2!.next(), "No stage after answerRevealed")
    }

    func testAdvanceTapInSession() {
        var session = StudySessionState(mode: .pictogramToEn, queue: [makeCard("cat")])
        XCTAssertEqual(session.revealStage, .imageOnly)

        XCTAssertFalse(session.advanceTap())
        XCTAssertEqual(session.revealStage, .englishRevealed)

        XCTAssertTrue(session.advanceTap())
        XCTAssertEqual(session.revealStage, .answerRevealed)
    }

    func testRevealStageResetsAfterRating() {
        var session = StudySessionState(mode: .pictogramToEn, queue: [makeCard("cat"), makeCard("dog")])
        session.advanceTap()
        session.advanceTap()
        session.rateCurrentCard(knew: true)

        XCTAssertEqual(session.revealStage, .imageOnly, "Stage should reset to imageOnly after rating")
        XCTAssertEqual(session.currentIndex, 1)
    }

    func testAdvanceTapAtFinalStageIsIdempotent() {
        var session = StudySessionState(mode: .enToJa, queue: [makeCard("cat")])
        session.advanceTap()
        session.advanceTap()
        // Already at answerRevealed — another tap should stay ratable
        XCTAssertTrue(session.advanceTap())
        XCTAssertEqual(session.revealStage, .answerRevealed)
    }
}

// MARK: - AgeBand

final class AgeBandTests: XCTestCase {

    private let cards: [VocabularyCard] = [
        makeCard("easy",   difficulty: 1),
        makeCard("medium", difficulty: 2),
        makeCard("hard",   difficulty: 3),
    ]

    func testToddlerFiltersToMaxDifficulty1() {
        let result = AgeBand.toddler.filter(cards)
        XCTAssertEqual(result.map(\.id), ["easy"])
    }

    func testPreschoolFiltersToMaxDifficulty2() {
        let result = AgeBand.preschool.filter(cards)
        XCTAssertEqual(result.map(\.id), ["easy", "medium"])
    }

    func testEarlyReaderAllowsAll() {
        let result = AgeBand.earlyReader.filter(cards)
        XCTAssertEqual(result.count, 3)
    }
}

// MARK: - SessionProgress

final class SessionProgressTests: XCTestCase {

    func testDefaultTargetCardCount() {
        XCTAssertEqual(SessionProgress.defaultTargetCardCount, 8)
    }

    func testFractionComplete() {
        let p = SessionProgress(totalCards: 8, completedCards: 4)
        XCTAssertEqual(p.fractionComplete, 0.5, accuracy: 0.001)
    }

    func testIsCompleteWhenExhausted() {
        var p = SessionProgress(totalCards: 2)
        XCTAssertFalse(p.isComplete)
        p = p.advancing()
        XCTAssertFalse(p.isComplete)
        p = p.advancing()
        XCTAssertTrue(p.isComplete)
    }

    func testProgressAdvancesWithRating() {
        var session = StudySessionState(mode: .enToJa, queue: [makeCard("cat"), makeCard("dog")])
        XCTAssertEqual(session.progress.completedCards, 0)
        session.advanceTap(); session.advanceTap()
        session.rateCurrentCard(knew: false)
        XCTAssertEqual(session.progress.completedCards, 1)
    }
}

// MARK: - ReviewQueueSeeder.buildSession

final class BuildSessionTests: XCTestCase {

    private let allCards = (1...10).map { makeCard("card\($0)") }

    func testFreshCardsFilledWhenNoRecords() {
        let session = ReviewQueueSeeder.buildSession(cards: allCards, records: [])
        XCTAssertEqual(session.count, SessionProgress.defaultTargetCardCount)
    }

    func testDueCardsHavePriority() {
        let past = Date(timeIntervalSinceNow: -86400)
        let future = Date(timeIntervalSinceNow: +86400 * 7)
        var records: [StudyRecord] = []
        // Mark card1–card3 as due (nextReviewAt in the past)
        for i in 1...3 {
            records.append(StudyRecord(cardID: "card\(i)", rating: .hard, reviewedAt: past, nextReviewAt: past))
        }
        // Mark card4–card6 as not due
        for i in 4...6 {
            records.append(StudyRecord(cardID: "card\(i)", rating: .ok, reviewedAt: past, nextReviewAt: future))
        }

        let session = ReviewQueueSeeder.buildSession(cards: allCards, records: records)
        let sessionIDs = Set(session.map(\.id))

        // All 3 due cards must be present
        XCTAssertTrue(sessionIDs.contains("card1"))
        XCTAssertTrue(sessionIDs.contains("card2"))
        XCTAssertTrue(sessionIDs.contains("card3"))
        XCTAssertEqual(session.count, SessionProgress.defaultTargetCardCount)
    }

    func testMaxDueCardsRespected() {
        let past = Date(timeIntervalSinceNow: -86400)
        let records = (1...6).map {
            StudyRecord(cardID: "card\($0)", rating: .hard, reviewedAt: past, nextReviewAt: past)
        }
        let session = ReviewQueueSeeder.buildSession(cards: allCards, records: records, maxDueCards: 3)
        let dueInSession = session.filter { Int($0.id.dropFirst(4))! <= 6 }
        XCTAssertLessThanOrEqual(dueInSession.count, 3, "At most maxDueCards due cards in session")
    }
}

// MARK: - KnewRating convenience

final class KnewRatingTests: XCTestCase {

    func testKnewTrueMapsToOk() {
        var session = StudySessionState(mode: .enToJa, queue: [makeCard("cat")])
        let fixedDate = Date(timeIntervalSinceReferenceDate: 0)
        session.advanceTap(); session.advanceTap()
        session.rateCurrentCard(knew: true, now: fixedDate)
        XCTAssertEqual(session.records.last?.rating, .ok)
    }

    func testKnewFalseMapsToHard() {
        var session = StudySessionState(mode: .enToJa, queue: [makeCard("cat")])
        let fixedDate = Date(timeIntervalSinceReferenceDate: 0)
        session.advanceTap(); session.advanceTap()
        session.rateCurrentCard(knew: false, now: fixedDate)
        XCTAssertEqual(session.records.last?.rating, .hard)
    }
}

// MARK: - Helpers

private func makeCard(_ id: String, difficulty: Int = 1) -> VocabularyCard {
    VocabularyCard(
        id: id,
        wordEN: id,
        wordJA: "\(id)JA",
        theme: "animals",
        difficulty: difficulty,
        emoji: "🐱",
        pictogramPrompt: "\(id) pictogram"
    )
}
