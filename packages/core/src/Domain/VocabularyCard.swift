import Foundation

public struct VocabularyCard: Codable, Equatable, Identifiable {
    public let id: String
    public let wordEN: String
    public let wordJA: String
    public let theme: String
    public let difficulty: Int
    public let emoji: String
    public let pictogramPrompt: String
    public let audioKey: String?

    public init(
        id: String,
        wordEN: String,
        wordJA: String,
        theme: String,
        difficulty: Int,
        emoji: String,
        pictogramPrompt: String,
        audioKey: String? = nil
    ) {
        self.id = id
        self.wordEN = wordEN
        self.wordJA = wordJA
        self.theme = theme
        self.difficulty = difficulty
        self.emoji = emoji
        self.pictogramPrompt = pictogramPrompt
        self.audioKey = audioKey
    }

    enum CodingKeys: String, CodingKey {
        case id
        case wordEN = "word_en"
        case wordJA = "word_ja"
        case theme
        case difficulty
        case emoji
        case pictogramPrompt = "pictogram_prompt"
        case audioKey = "audio_key"
    }
}
