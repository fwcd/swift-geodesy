/// One of the four main compass directions.
public enum Cardinal: String, Codable, Hashable, CustomStringConvertible, Sendable {
    case north = "N"
    case west = "W"
    case south = "S"
    case east = "E"
    
    public var description: String { rawValue }
}
