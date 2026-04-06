import Foundation

/// Persists `TownState` to `UserDefaults`.
///
/// Inject a custom `UserDefaults` suite for testing or app-group sharing.
///
/// Usage:
/// ```swift
/// let store = TownStore()
/// var town = store.load()
/// town = town.applying(card: card, knew: true, isReview: false)
/// store.save(town)
/// ```
public final class TownStore {

    private let defaults: UserDefaults
    private let friendshipsKey = "pictan_friendships"
    private let residentsKey   = "pictan_residents"

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
    }

    // MARK: - Load

    public func load() -> TownState {
        let friendships = loadFriendships()
        let residents   = loadResidents()
        return TownState(friendships: friendships, residents: residents)
    }

    // MARK: - Save

    public func save(_ state: TownState) {
        saveFriendships(state.friendships)
        saveResidents(state.residents)
    }

    // MARK: - Convenience

    /// Load, apply a card rating, save, and return the updated state.
    @discardableResult
    public func applyRating(
        card: VocabularyCard,
        knew: Bool,
        isReview: Bool,
        now: Date = Date()
    ) -> TownState {
        let current = load()
        let updated = current.applying(card: card, knew: knew, isReview: isReview, now: now)
        save(updated)
        return updated
    }

    /// Remove all persisted town data (useful for testing and account reset).
    public func reset() {
        defaults.removeObject(forKey: friendshipsKey)
        defaults.removeObject(forKey: residentsKey)
    }

    // MARK: - Private helpers

    private func loadFriendships() -> [String: Int] {
        guard let data = defaults.data(forKey: friendshipsKey),
              let value = try? decoder.decode([String: Int].self, from: data)
        else { return [:] }
        return value
    }

    private func saveFriendships(_ friendships: [String: Int]) {
        guard let data = try? encoder.encode(friendships) else { return }
        defaults.set(data, forKey: friendshipsKey)
    }

    private func loadResidents() -> [TownResident] {
        guard let data = defaults.data(forKey: residentsKey),
              let value = try? decoder.decode([TownResident].self, from: data)
        else { return [] }
        return value
    }

    private func saveResidents(_ residents: [TownResident]) {
        guard let data = try? encoder.encode(residents) else { return }
        defaults.set(data, forKey: residentsKey)
    }
}
