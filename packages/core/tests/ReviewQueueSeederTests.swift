import Foundation
import XCTest
@testable import PicTanCore

final class ReviewQueueSeederTests: XCTestCase {
    private var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal
    }

    private var baseDate: Date {
        Date(timeIntervalSince1970: 1_700_000_000)
    }

    func testNextReviewDateForPerfect() {
        let next = ReviewQueueSeeder.nextReviewDate(from: baseDate, rating: .perfect, calendar: calendar)
        XCTAssertEqual(next, calendar.date(byAdding: .day, value: 7, to: baseDate))
    }

    func testNextReviewDateForOk() {
        let next = ReviewQueueSeeder.nextReviewDate(from: baseDate, rating: .ok, calendar: calendar)
        XCTAssertEqual(next, calendar.date(byAdding: .day, value: 3, to: baseDate))
    }

    func testNextReviewDateForHard() {
        let next = ReviewQueueSeeder.nextReviewDate(from: baseDate, rating: .hard, calendar: calendar)
        XCTAssertEqual(next, calendar.date(byAdding: .day, value: 1, to: baseDate))
    }

    func testNextReviewDateForUnknown() {
        let next = ReviewQueueSeeder.nextReviewDate(from: baseDate, rating: .unknown, calendar: calendar)
        XCTAssertEqual(next, baseDate)
    }

    func testSeedQueueIncludesOnlyDueCards() {
        let cards = [
            VocabularyCard(id: "a", wordEN: "cat", wordJA: "ねこ", theme: "animals", difficulty: 1, pictogramPrompt: "x"),
            VocabularyCard(id: "b", wordEN: "dog", wordJA: "いぬ", theme: "animals", difficulty: 1, pictogramPrompt: "y")
        ]

        let records = [
            StudyRecord(cardID: "a", rating: .hard, reviewedAt: baseDate, nextReviewAt: baseDate),
            StudyRecord(cardID: "b", rating: .perfect, reviewedAt: baseDate, nextReviewAt: calendar.date(byAdding: .day, value: 7, to: baseDate)!)
        ]

        let seeded = ReviewQueueSeeder.seedQueue(cards: cards, dueAt: baseDate, records: records)
        XCTAssertEqual(seeded.map(\.id), ["a"])
    }
}
