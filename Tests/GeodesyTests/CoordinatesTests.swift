import XCTest
@testable import Geodesy

class CoordinatesTests: XCTestCase {
    func testHeading() {
        let a = Coordinates(latitude: 0, longitude: 0)
        let b = Coordinates(latitude: 0, longitude: 90)
        let c = Coordinates(latitude: 90, longitude: 0)
        let d = Coordinates(latitude: 90, longitude: 90)
        
        assertApproxEquals(a.heading(to: b), .init(degrees: 90))
        assertApproxEquals(a.heading(to: c), .zero)
        assertApproxEquals(a.heading(to: d), .zero)
    }
}
