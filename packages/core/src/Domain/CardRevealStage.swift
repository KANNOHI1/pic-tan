import Foundation

/// The 3-stage progressive reveal flow for a flashcard.
///
/// Design flow (spec 2026-03-19, §3 Screen 3):
///   ```
///   imageOnly → (tap) → englishRevealed → (tap) → answerRevealed → (rate) → next card
///   ```
public enum CardRevealStage: Equatable {
    /// Stage 0: Picture shown, tap hint "こたえは？" visible.
    case imageOnly
    /// Stage 1: English word revealed in large type after first tap.
    case englishRevealed
    /// Stage 2: Japanese word shown below English; rating buttons appear.
    case answerRevealed

    /// Whether the user may rate the card at this stage.
    public var isRatable: Bool { self == .answerRevealed }

    /// Advance to the next stage. Returns `nil` if already at the final stage.
    public func next() -> CardRevealStage? {
        switch self {
        case .imageOnly:       return .englishRevealed
        case .englishRevealed: return .answerRevealed
        case .answerRevealed:  return nil
        }
    }
}
