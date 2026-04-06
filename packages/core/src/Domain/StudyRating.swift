import Foundation

public enum StudyRating: String, Codable, CaseIterable {
    case perfect
    case ok
    case hard
    case unknown

    public var intervalDays: Int {
        switch self {
        case .perfect:
            return 7
        case .ok:
            return 3
        case .hard:
            return 1
        case .unknown:
            return 0
        }
    }
}
