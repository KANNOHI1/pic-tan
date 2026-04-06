import Foundation

/// Parent-configurable app settings persisted to UserDefaults.
///
/// Currently covers:
///   - `ageBand`: vocabulary difficulty filter (2-3yo / 4-5yo / 6+yo)
public final class ParentSettings {

    private let defaults: UserDefaults
    private let ageBandKey = "pictan_age_band"

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    /// Currently selected age band. Defaults to `.preschool` (4-5yo).
    public var ageBand: AgeBand {
        get {
            guard let raw = defaults.string(forKey: ageBandKey),
                  let band = AgeBand(rawValue: raw) else { return .preschool }
            return band
        }
        set {
            defaults.set(newValue.rawValue, forKey: ageBandKey)
        }
    }

    /// Reset to factory defaults.
    public func reset() {
        defaults.removeObject(forKey: ageBandKey)
    }
}
