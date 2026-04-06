import Foundation

public enum StudyMode: String, Codable, CaseIterable {
    case enToJa = "en_to_ja"
    case jaToEn = "ja_to_en"
    case pictogramToEn = "pictogram_to_en"
    case pictogramToJa = "pictogram_to_ja"

    public var isImageMode: Bool {
        self == .pictogramToEn || self == .pictogramToJa
    }

    public func prompt(for card: VocabularyCard) -> String {
        switch self {
        case .enToJa:
            return card.wordEN
        case .jaToEn:
            return card.wordJA
        case .pictogramToEn, .pictogramToJa:
            return card.emoji
        }
    }

    public func answer(for card: VocabularyCard) -> String {
        switch self {
        case .enToJa, .pictogramToJa:
            return card.wordJA
        case .jaToEn, .pictogramToEn:
            return card.wordEN
        }
    }
}
