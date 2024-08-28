import Foundation

/// East or West.
public enum LongitudeCardinal: String, Codable, Hashable, CaseIterable, CustomStringConvertible, SignedCardinal {
    case east = "E"
    case west = "W"
    
    public var description: String { rawValue }
    public var sign: FloatingPointSign {
        switch self {
        case .east: return .plus
        case .west: return .minus
        }
    }
    public var asCardinal: Cardinal {
        switch self {
        case .east: return .east
        case .west: return .west
        }
    }
    
    public init(sign: FloatingPointSign) {
        switch sign {
        case .plus: self = .east
        case .minus: self = .west
        }
    }
}
