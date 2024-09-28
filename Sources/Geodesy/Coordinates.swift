import Foundation

/// A pair of geographical coordinates on Earth.
public struct Coordinates: AdditiveArithmetic, Codable, Hashable, CustomStringConvertible, Sendable {
    /// Null island.
    public static let zero = Coordinates(latitude: 0, longitude: 0)

    /// The latitude coordinate in degrees.
    public var latitude: Degrees
    /// The longitude coordinate in degrees.
    public var longitude: Degrees
    
    /// North or south.
    public var latitudeCardinal: LatitudeCardinal {
        get { LatitudeCardinal(sign: latitude.sign) }
        set { latitude.sign = newValue.sign }
    }
    /// East or west.
    public var longitudeCardinal: LongitudeCardinal {
        get { LongitudeCardinal(sign: longitude.sign) }
        set { longitude.sign = newValue.sign }
    }
    
    public var description: String { "\(latitudeCardinal) \(latitude.magnitude), \(longitudeCardinal) \(longitude.magnitude)" }
    
    public init() {
        self.init(latitude: .zero, longitude: .zero)
    }
    
    public init(latitude: Degrees, longitude: Degrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(latitude: Double, longitude: Double) {
        self.init(latitude: Degrees(degrees: latitude), longitude: Degrees(degrees: longitude))
    }
    
    public func heading(to rhs: Coordinates) -> Degrees {
        // Source: https://stackoverflow.com/questions/3932502/calculate-angle-between-two-latitude-longitude-points
        let (lat1, lon1) = (latitude.totalRadians, longitude.totalRadians)
        let (lat2, lon2) = (rhs.latitude.totalRadians, rhs.longitude.totalRadians)
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        return Degrees(radians: atan2(y, x))
    }

    public func map(_ transform: (Degrees) -> Degrees) -> Self {
        Self(
            latitude: transform(latitude),
            longitude: transform(longitude)
        )
    }

    public func zip(_ rhs: Self, with combiner: (Degrees, Degrees) -> Degrees) -> Self {
        Self(
            latitude: combiner(latitude, rhs.latitude),
            longitude: combiner(longitude, rhs.longitude)
        )
    }

    public func min(_ rhs: Self) -> Self {
        zip(rhs, with: Swift.min)
    }

    public func max(_ rhs: Self) -> Self {
        zip(rhs, with: Swift.max)
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        lhs.zip(rhs, with: +)
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        lhs.zip(rhs, with: -)
    }

    public static func *(lhs: Self, rhs: Double) -> Self {
        lhs.map { $0 * rhs }
    }

    public static func *(lhs: Double, rhs: Self) -> Self {
        rhs.map { lhs * $0 }
    }

    public static func /(lhs: Self, rhs: Double) -> Self {
        lhs.map { $0 / rhs }
    }
}
