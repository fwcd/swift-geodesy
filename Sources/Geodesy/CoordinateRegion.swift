/// A positioned rectangular geographical region.
public struct CoordinateRegion: Hashable, Codable, Sendable {
    /// The coordinates of the region's center.
    public var center: Coordinates
    /// The size of the region.
    public var span: CoordinateSpan

    /// The top left corner of the region.
    public var topLeft: Coordinates {
        get {
            Coordinates(
                latitude: center.latitude + span.latitudeDelta / 2,
                longitude: center.longitude - span.longitudeDelta / 2
            )
        }
        set {
            self = Self(topLeft: newValue, bottomRight: bottomRight)
        }
    }

    /// The bottom right corner of the region.
    public var bottomRight: Coordinates {
        get {
            Coordinates(
                latitude: center.latitude - span.latitudeDelta / 2,
                longitude: center.longitude + span.longitudeDelta / 2
            )
        }
        set {
            self = Self(topLeft: topLeft, bottomRight: newValue)
        }
    }

    /// The bottom left (min) corner of the region.
    public var bottomLeft: Coordinates {
        get {
            Coordinates(
                latitude: bottomRight.latitude,
                longitude: topLeft.longitude
            )
        }
        set {
            self = Self(bottomLeft: newValue, topRight: topRight)
        }
    }
    
    /// The top right (max) corner of the region.
    public var topRight: Coordinates {
        get {
            Coordinates(
                latitude: topLeft.latitude,
                longitude: bottomRight.longitude
            )
        }
        set {
            self = Self(bottomLeft: bottomLeft, topRight: newValue)
        }
    }

    /// The bottom left (min) corner of the region.
    public var minCorner: Coordinates {
        get { bottomLeft }
        set { bottomLeft = newValue }
    }

    /// The top right (max) corner of the region.
    public var maxCorner: Coordinates {
        get { topRight }
        set { topRight = newValue }
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

    public init(bottomLeft: Coordinates, topRight: Coordinates) {
        self.init(
            center: (bottomLeft + topRight) / 2,
            span: .init(
                latitudeDelta: topRight.latitude - bottomLeft.latitude,
                longitudeDelta: topRight.longitude - bottomLeft.longitude
            )
        )
    }

    public init(minCorner: Coordinates, maxCorner: Coordinates) {
        self.init(bottomLeft: minCorner, topRight: maxCorner)
    }

    public func contains(_ location: Coordinates) -> Bool {
        // TODO: This naive version may fail where coordinates wrap around
        (min(topLeft.latitude, bottomRight.latitude)...max(topLeft.latitude, bottomRight.latitude)).contains(location.latitude)
            && (min(topLeft.longitude, bottomRight.longitude)...max(topLeft.longitude, bottomRight.longitude)).contains(location.longitude)
    }
}
