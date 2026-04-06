import Foundation
import XCTest
@testable import PicTanCore

final class VocabularyCardDecodingTests: XCTestCase {

    func testDecodesVocabularyCardWithEmoji() throws {
        let json = """
        [
          {
            "id": "animal_cat",
            "word_en": "cat",
            "word_ja": "ねこ",
            "theme": "animals",
            "difficulty": 1,
            "emoji": "🐱",
            "pictogram_prompt": "felt doll style cat character, warm diorama background"
          }
        ]
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode([VocabularyCard].self, from: json)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.id, "animal_cat")
        XCTAssertEqual(decoded.first?.wordEN, "cat")
        XCTAssertEqual(decoded.first?.wordJA, "ねこ")
        XCTAssertEqual(decoded.first?.emoji, "🐱")
        XCTAssertEqual(decoded.first?.pictogramPrompt, "felt doll style cat character, warm diorama background")
        XCTAssertNil(decoded.first?.audioKey)
    }

    func testDecodesMultipleThemes() throws {
        let json = """
        [
          {
            "id": "fruit_apple",
            "word_en": "apple",
            "word_ja": "りんご",
            "theme": "fruits",
            "difficulty": 1,
            "emoji": "🍎",
            "pictogram_prompt": "felt doll style apple"
          },
          {
            "id": "color_red",
            "word_en": "red",
            "word_ja": "あか",
            "theme": "colors",
            "difficulty": 1,
            "emoji": "🔴",
            "pictogram_prompt": "felt doll style red circle"
          }
        ]
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode([VocabularyCard].self, from: json)

        XCTAssertEqual(decoded.count, 2)
        XCTAssertEqual(decoded[0].emoji, "🍎")
        XCTAssertEqual(decoded[0].theme, "fruits")
        XCTAssertEqual(decoded[1].emoji, "🔴")
        XCTAssertEqual(decoded[1].theme, "colors")
    }

    func testDecodingFailsWhenEmojiFieldMissing() throws {
        let json = """
        [
          {
            "id": "animal_cat",
            "word_en": "cat",
            "word_ja": "ねこ",
            "theme": "animals",
            "difficulty": 1,
            "pictogram_prompt": "felt doll style cat character"
          }
        ]
        """.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode([VocabularyCard].self, from: json)) { error in
            XCTAssertTrue(error is DecodingError, "Expected DecodingError when emoji is missing")
        }
    }
}
