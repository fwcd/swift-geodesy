import Foundation

/// North or South.
public enum LatitudeCardinal: String, Codable, Hashable, CaseIterable, CustomStringConvertible, SignedCardinal {
    case north = "N"
    case south = "S"
    
    public var description: String { rawValue }
    
    public var sign: FloatingPointSign {
        switch self {
        case .north: return .plus
        case .south: return .minus
        }
    }
    public var asCardinal: Cardinal {
        switch self {
        case .north: return .north
        case .south: return .south
        }
    }
    
    public init(sign: FloatingPointSign) {
        switch sign {
        case .plus: self = .north
        case .minus: self = .south
        }
    }
}
