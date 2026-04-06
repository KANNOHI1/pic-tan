import Foundation
import PicTanCore

/// Loads vocabulary content from JSON files bundled in the app target.
///
/// Bundle resource naming: `{theme}_{locale}.json`
/// e.g. animals_ja-JP.json, fruits_ja-JP.json, colors_ja-JP.json
enum ContentLoader {

    enum LoadError: Error {
        case fileNotFound(String)
        case decodingFailed(Error)
    }

    struct ThemeInfo {
        let id: String
        let nameJA: String
        let nameEN: String
        let emoji: String
    }

    static let availableThemes: [ThemeInfo] = [
        ThemeInfo(id: "animals", nameJA: "どうぶつ", nameEN: "Animals", emoji: "🐾"),
        ThemeInfo(id: "fruits",  nameJA: "くだもの", nameEN: "Fruits",  emoji: "🍎"),
        ThemeInfo(id: "colors",  nameJA: "いろ",     nameEN: "Colors",  emoji: "🎨"),
    ]

    /// Loads all cards for the given theme and locale.
    /// - Parameters:
    ///   - theme: Theme ID, e.g. "animals", "fruits", "colors"
    ///   - locale: BCP-47 tag, e.g. "ja-JP" or "en-US"
    static func loadCards(theme: String, locale: String = "ja-JP") throws -> [VocabularyCard] {
        let resourceName = "\(theme)_\(locale)"
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "json") else {
            throw LoadError.fileNotFound("\(resourceName).json")
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([VocabularyCard].self, from: data)
        } catch {
            throw LoadError.decodingFailed(error)
        }
    }

    /// Convenience: load animals (backward-compatible).
    static func loadAnimals(locale: String = "ja-JP") throws -> [VocabularyCard] {
        try loadCards(theme: "animals", locale: locale)
    }
}
