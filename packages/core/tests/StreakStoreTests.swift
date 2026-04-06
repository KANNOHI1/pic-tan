import XCTest
@testable import PicTanCore

final class StreakStoreTests: XCTestCase {

    private var suiteName: String!
    private var store: StreakStore!

    override func setUp() {
        super.setUp()
        suiteName = "PicTanCoreTests_Streak_\(UUID().uuidString)"
        store = StreakStore(defaults: UserDefaults(suiteName: suiteName)!)
    }

    override func tearDown() {
        store.reset()
        UserDefaults().removePersistentDomain(forName: suiteName)
        super.tearDown()
    }

    func testEmptyLoadReturnsZero() {
        XCTAssertEqual(store.load().count, 0)
        XCTAssertNil(store.load().lastDate)
    }

    func testFirstRecordGivesStreakOne() {
        let info = store.recordToday()
        XCTAssertEqual(info.count, 1)
        XCTAssertNotNil(info.lastDate)
    }

    func testRecordSameDayIsIdempotent() {
        store.recordToday()
        let info = store.recordToday()
        XCTAssertEqual(info.count, 1, "Recording twice in a day should not increment count")
    }

    func testConsecutiveDaysIncrement() {
        // Simulate today then yesterday-but-for-the-store
        // We do this by recording "yesterday" manually, then recording today.
        let defaults = UserDefaults(suiteName: suiteName)!
        let yesterday = dateString(daysAgo: 1)
        defaults.set(1, forKey: "pictan_streak_count")
        defaults.set(yesterday, forKey: "pictan_streak_date")

        let info = store.recordToday()
        XCTAssertEqual(info.count, 2)
    }

    func testBrokenStreakResetsToOne() {
        let defaults = UserDefaults(suiteName: suiteName)!
        let twoDaysAgo = dateString(daysAgo: 2)
        defaults.set(5, forKey: "pictan_streak_count")
        defaults.set(twoDaysAgo, forKey: "pictan_streak_date")

        let info = store.recordToday()
        XCTAssertEqual(info.count, 1, "Missed a day — streak should reset to 1")
    }

    func testResetClearsStreak() {
        store.recordToday()
        store.reset()
        XCTAssertEqual(store.load().count, 0)
    }

    // MARK: - ParentSettings

    func testParentSettingsDefaultsToPreschool() {
        let settingsSuite = "PicTanCoreTests_PS_\(UUID().uuidString)"
        let settings = ParentSettings(defaults: UserDefaults(suiteName: settingsSuite)!)
        XCTAssertEqual(settings.ageBand, .preschool)
        UserDefaults().removePersistentDomain(forName: settingsSuite)
    }

    func testParentSettingsPersists() {
        let settingsSuite = "PicTanCoreTests_PS2_\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: settingsSuite)!
        let settings = ParentSettings(defaults: defaults)
        settings.ageBand = .toddler
        let reloaded = ParentSettings(defaults: defaults)
        XCTAssertEqual(reloaded.ageBand, .toddler)
        UserDefaults().removePersistentDomain(forName: settingsSuite)
    }

    // MARK: - Helpers

    private func dateString(daysAgo n: Int) -> String {
        let d = Calendar.current.date(byAdding: .day, value: -n, to: Date())!
        let c = Calendar.current.dateComponents([.year, .month, .day], from: d)
        return String(format: "%04d-%02d-%02d", c.year!, c.month!, c.day!)
    }
}
