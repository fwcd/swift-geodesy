#if canImport(MapKit)
import MapKit

extension CoordinateSpan {
    init(_ mkSpan: MKCoordinateSpan) {
        self.init(
            latitudeDelta: .init(degrees: mkSpan.latitudeDelta),
            longitudeDelta: .init(degrees: mkSpan.longitudeDelta)
        )
    }
}
#endif
