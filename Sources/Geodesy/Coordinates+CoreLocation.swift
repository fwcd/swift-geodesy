#if canImport(CoreLocation)
import CoreLocation

extension Coordinates {
    public var asCLCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude.totalDegrees, longitude: longitude.totalDegrees)
    }

    public var asCLLocation: CLLocation {
        CLLocation(latitude: latitude.totalDegrees, longitude: longitude.totalDegrees)
    }

    public init(_ clCoordinate: CLLocationCoordinate2D) {
        self.init(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
    }

    // TODO: Add platform-independent distance implementation and move it to Coordinates
    public func distance(to rhs: Coordinates) -> Length {
        Length(meters: asCLLocation.distance(from: rhs.asCLLocation).magnitude)
    }
}
#endif
