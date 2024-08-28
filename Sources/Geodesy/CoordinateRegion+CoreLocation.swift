#if canImport(CoreLocation)
extension CoordinateRegion {
    public var diameter: Length {
        topLeft.distance(to: bottomRight)
    }
}
#endif
