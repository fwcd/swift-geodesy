/// An angle in degrees.
public struct Degrees: AdditiveArithmetic, Hashable, Comparable, Codable, CustomStringConvertible, Sendable {
    public static var zero = Degrees()
    
    // Decimal degrees (internal representation)
    public var totalDegrees: Double
    
    // Angle in radians
    public var totalRadians: Double {
        get { totalDegrees * .pi / 180 }
        set { totalDegrees = newValue / .pi * 180 }
    }
    
    /// Absolute value of the total degrees.
    public var absoluteDegrees: Double {
        get { abs(totalDegrees) }
        set { totalDegrees = totalDegrees.sign.asDouble * abs(newValue) }
    }
    
    /// Floating-point sign.
    public var sign: FloatingPointSign {
        get { totalDegrees.sign }
        set { totalDegrees = newValue.asDouble * absoluteDegrees }
    }
    
    /// Degrees and decimal minutes
    public var dm: (degrees: Int, minutes: Double) {
        get {
            let totalMinutes = totalDegrees * 60
            let minutes = totalMinutes.truncatingRemainder(dividingBy: 60)
            let degrees = Int(totalMinutes) / 60
            return (degrees: degrees, minutes: minutes)
        }
        set {
            totalDegrees = Double(newValue.degrees) + (newValue.minutes / 60)
        }
    }
    
    /// Degrees, minutes and decimal seconds
    public var dms: (degrees: Int, minutes: Int, seconds: Double) {
        get {
            let (degrees, remTotalMinutes) = dm
            let remTotalSeconds = remTotalMinutes * 60
            let seconds = remTotalSeconds.truncatingRemainder(dividingBy: 60)
            let minutes = Int(remTotalSeconds) / 60
            return (degrees: degrees, minutes: minutes, seconds: seconds)
        }
        set {
            totalDegrees = Double(newValue.degrees) + (Double(newValue.minutes) / 60) + (newValue.seconds / 3600)
        }
    }
    
    /// The absolute value
    public var magnitude: Degrees {
        get { Degrees(degrees: absoluteDegrees) }
        set { absoluteDegrees = abs(newValue.totalDegrees) }
    }
    
    public var description: String { String(format: "%d° %.3f'", dm.degrees, dm.minutes) }
    public var shortDescription: String { String(format: "%d°", dm.degrees) }
    
    public init() {
        self.init(degrees: 0)
    }
    
    public init(degrees: Double) {
        totalDegrees = degrees
    }
    
    public init(radians: Double) {
        self.init()
        totalRadians = radians
    }
    
    public init(degrees: Int, minutes: Double) {
        self.init()
        dm = (degrees: degrees, minutes: minutes)
    }
    
    public init(degrees: Int, minutes: Int, seconds: Double) {
        self.init()
        dms = (degrees: degrees, minutes: minutes, seconds: seconds)
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        Self(degrees: lhs.totalDegrees + rhs.totalDegrees)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        Self(degrees: lhs.totalDegrees - rhs.totalDegrees)
    }
    
    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.totalDegrees += rhs.totalDegrees
    }
    
    public static func -=(lhs: inout Self, rhs: Self) {
        lhs.totalDegrees -= rhs.totalDegrees
    }
    
    public static func *(lhs: Self, factor: Double) -> Self {
        Self(degrees: lhs.totalDegrees * factor)
    }
    
    public static func *(factor: Double, rhs: Self) -> Self {
        Self(degrees: rhs.totalDegrees * factor)
    }
    
    public static func /(lhs: Self, divisor: Double) -> Self {
        Self(degrees: lhs.totalDegrees / divisor)
    }
    
    public static func *=(lhs: inout Self, factor: Double) {
        lhs.totalDegrees *= factor
    }
    
    public static func /=(lhs: inout Self, divisor: Double) {
        lhs.totalDegrees /= divisor
    }
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.totalDegrees < rhs.totalDegrees
    }
    
    public static prefix func -(lhs: Self) -> Self {
        Self(degrees: -lhs.totalDegrees)
    }
    
    public mutating func negate() {
        totalDegrees.negate()
    }
}
