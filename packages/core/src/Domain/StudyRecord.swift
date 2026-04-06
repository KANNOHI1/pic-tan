import Foundation

public struct StudyRecord: Codable, Equatable {
    public let cardID: String
    public let rating: StudyRating
    public let reviewedAt: Date
    public let nextReviewAt: Date

    public init(cardID: String, rating: StudyRating, reviewedAt: Date, nextReviewAt: Date) {
        self.cardID = cardID
        self.rating = rating
        self.reviewedAt = reviewedAt
        self.nextReviewAt = nextReviewAt
    }
}
