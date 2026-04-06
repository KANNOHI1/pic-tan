import Foundation

/// Age-band difficulty filter for vocabulary cards.
///
/// Pic-tan targets 2–6 year olds. Cards carry a `difficulty` field (1 = easiest).
/// Choosing an age band restricts the card pool to age-appropriate difficulty.
public enum AgeBand: String, CaseIterable, Codable {
    /// 2–3 years old: core vocabulary only (difficulty ≤ 1).
    case toddler = "2-3"
    /// 4–5 years old: expanded vocabulary (difficulty ≤ 2).
    case preschool = "4-5"
    /// 6+ years old: all cards.
    case earlyReader = "6+"

    /// Maximum `VocabularyCard.difficulty` allowed for this band.
    public var maxDifficulty: Int {
        switch self {
        case .toddler:     return 1
        case .preschool:   return 2
        case .earlyReader: return Int.max
        }
    }

    /// Return only cards whose difficulty is within this age band.
    public func filter(_ cards: [VocabularyCard]) -> [VocabularyCard] {
        cards.filter { $0.difficulty <= maxDifficulty }
    }
}
