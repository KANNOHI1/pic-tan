import Foundation

/// Persists and computes the daily study streak.
///
/// A streak increments when the learner completes at least one session each
/// consecutive calendar day. Missing a day resets the count to 1.
///
/// Usage:
/// ```swift
/// let store = StreakStore()
/// let streak = store.recordToday()   // call once per completed session
/// print(streak.count)               // current streak
/// ```
public final class StreakStore {

    // MARK: - Types

    public struct StreakInfo: Equatable {
        /// Consecutive days (1 = just today, 0 = never studied).
        public let count: Int
        /// ISO-8601 date string of last recorded study day (yyyy-MM-dd).
        public let lastDate: String?

        public static let empty = StreakInfo(count: 0, lastDate: nil)

        public init(count: Int, lastDate: String?) {
            self.count = count
            self.lastDate = lastDate
        }
    }

    // MARK: - Init

    private let defaults: UserDefaults
    private let countKey = "pictan_streak_count"
    private let dateKey  = "pictan_streak_date"

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Read

    public func load() -> StreakInfo {
        let count = defaults.integer(forKey: countKey)
        let date  = defaults.string(forKey: dateKey)
        return StreakInfo(count: count, lastDate: date)
    }

    // MARK: - Write

    /// Record a session completed today.
    /// - Returns: Updated `StreakInfo` with the new count.
    @discardableResult
    public func recordToday(calendar: Calendar = .current) -> StreakInfo {
        let today = dateString(for: Date(), calendar: calendar)
        let current = load()

        let newCount: Int
        if current.lastDate == today {
            // Already counted today — no change.
            return current
        } else if let last = current.lastDate,
                  isYesterday(last, relativeTo: today, calendar: calendar) {
            newCount = current.count + 1
        } else {
            newCount = 1
        }

        defaults.set(newCount, forKey: countKey)
        defaults.set(today, forKey: dateKey)
        return StreakInfo(count: newCount, lastDate: today)
    }

    /// Remove persisted streak data.
    public func reset() {
        defaults.removeObject(forKey: countKey)
        defaults.removeObject(forKey: dateKey)
    }

    // MARK: - Helpers

    private func dateString(for date: Date, calendar: Calendar) -> String {
        let comps = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", comps.year!, comps.month!, comps.day!)
    }

    private func isYesterday(_ dateStr: String, relativeTo today: String, calendar: Calendar) -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.calendar = calendar
        guard let d = fmt.date(from: dateStr) else { return false }
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: d).flatMap { fmt.string(from: $0) }
        return tomorrow == today
    }
}
