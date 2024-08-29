#if canImport(MapKit)
import MapKit

extension CoordinateRegion {
    init(_ mkRegion: MKCoordinateRegion) {
        self.init(
            center: Coordinates(mkRegion.center),
            span: CoordinateSpan(mkRegion.span)
        )
    }
}
#endif
