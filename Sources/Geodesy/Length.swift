public struct Length: AdditiveArithmetic, Hashable, Comparable, Codable, CustomStringConvertible {
    public static var zero = Length()
    
    public var meters: Double
    public var description: String {
        if meters < 0.01 {
            return String(format: "%d mm", Int(self.as(.millimeters)))
        } else if meters < 1 {
            return String(format: "%d cm", Int(self.as(.centimeters)))
        } else if meters < 1000 {
            return String(format: "%d m", Int(meters))
        } else {
            return String(format: "%.1f km", self.as(.kilometers))
        }
    }
    
    public init() {
        self.init(meters: 0)
    }
    
    public init(meters: Double) {
        self.meters = meters
    }
    
    public init(_ value: Double, _ unit: Unit) {
        meters = value * unit.rawValue
    }
    
    public func `as`(_ unit: Unit) -> Double {
        meters / unit.rawValue
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        Self(meters: lhs.meters + rhs.meters)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        Self(meters: lhs.meters - rhs.meters)
    }
    
    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.meters += rhs.meters
    }
    
    public static func -=(lhs: inout Self, rhs: Self) {
        lhs.meters -= rhs.meters
    }
    
    public static func *(lhs: Self, factor: Double) -> Self {
        Self(meters: lhs.meters * factor)
    }
    
    public static func *(factor: Double, rhs: Self) -> Self {
        Self(meters: rhs.meters * factor)
    }
    
    public static func /(lhs: Self, divisor: Double) -> Self {
        Self(meters: lhs.meters / divisor)
    }
    
    public static func *=(lhs: inout Self, factor: Double) {
        lhs.meters *= factor
    }
    
    public static func /=(lhs: inout Self, divisor: Double) {
        lhs.meters /= divisor
    }
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.meters < rhs.meters
    }
    
    public static prefix func -(lhs: Self) -> Self {
        Self(meters: -lhs.meters)
    }
    
    public mutating func negate() {
        meters.negate()
    }
    
    public enum Unit: Double {
        case kilometers = 1000
        case meters = 1
        case centimeters = 0.01
        case millimeters = 0.001
        case feet = 0.3048
        case inches = 0.0254
        case yards = 0.9144
        case miles = 1609.34
    }
}
