/// A positioned rectangular geographical region.
public struct CoordinateRegion: Hashable, Codable, Sendable {
    /// The coordinates of the region's center.
    public let center: Coordinates
    /// The size of the region.
    public let span: CoordinateSpan

    /// The top left corner of the region.
    public var topLeft: Coordinates {
        Coordinates(
            latitude: center.latitude + span.latitudeDelta / 2,
            longitude: center.longitude - span.longitudeDelta / 2
        )
    }

    /// The bottom right corner of the region.
    public var bottomRight: Coordinates {
        Coordinates(
            latitude: center.latitude - span.latitudeDelta / 2,
            longitude: center.longitude + span.longitudeDelta / 2
        )
    }

    /// The bottom left (min) corner of the region.
    public var bottomLeft: Coordinates {
        Coordinates(
            latitude: bottomRight.latitude,
            longitude: topLeft.longitude
        )
    }
    
    /// The top right (max) corner of the region.
    public var topRight: Coordinates {
        Coordinates(
            latitude: topLeft.latitude,
            longitude: bottomRight.longitude
        )
    }

    /// The bottom left (min) corner of the region.
    public var minCorner: Coordinates {
        bottomLeft
    }

    /// The top right (max) corner of the region.
    public var maxCorner: Coordinates {
        topRight
    }

    public init(center: Coordinates, span: CoordinateSpan) {
        self.center = center
        self.span = span
    }

    public init(topLeft: Coordinates, bottomRight: Coordinates) {
        self.init(
            center: (topLeft + bottomRight) / 2,
            span: .init(
                latitudeDelta: topLeft.latitude - bottomRight.latitude,
                longitudeDelta: bottomRight.longitude - topLeft.longitude
            )
        )
    }

    public func contains(_ location: Coordinates) -> Bool {
        // TODO: This naive version may fail where coordinates wrap around
        (min(topLeft.latitude, bottomRight.latitude)...max(topLeft.latitude, bottomRight.latitude)).contains(location.latitude)
            && (min(topLeft.longitude, bottomRight.longitude)...max(topLeft.longitude, bottomRight.longitude)).contains(location.longitude)
    }
}
