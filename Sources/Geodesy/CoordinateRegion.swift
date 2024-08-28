public struct CoordinateRegion: Codable, Hashable {
    public let topLeft: Coordinates
    public let bottomRight: Coordinates
    
    public var topRight: Coordinates {
        Coordinates(
            latitude: topLeft.latitude,
            longitude: bottomRight.longitude
        )
    }
    public var bottomLeft: Coordinates {
        Coordinates(
            latitude: bottomRight.latitude,
            longitude: topLeft.longitude
        )
    }
    public var center: Coordinates {
        Coordinates(
            latitude: (topLeft.latitude + bottomRight.latitude) / 2,
            longitude: (topLeft.longitude + bottomRight.longitude) / 2
        )
    }
    
    public func contains(_ location: Coordinates) -> Bool {
        // TODO: This naive version may fail where coordinates wrap around
        (min(topLeft.latitude, bottomRight.latitude)...max(topLeft.latitude, bottomRight.latitude)).contains(location.latitude)
            && (min(topLeft.longitude, bottomRight.longitude)...max(topLeft.longitude, bottomRight.longitude)).contains(location.longitude)
    }
}
