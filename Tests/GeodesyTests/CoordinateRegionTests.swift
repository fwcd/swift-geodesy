import XCTest
@testable import Geodesy

private let eps = 0.001

class CoordinateRegionTests: XCTestCase {
    func testInitializers() {
        let topLeft = Coordinates(latitude: 10, longitude: 20)
        let bottomRight = Coordinates(latitude: 30, longitude: 40)
        let region = CoordinateRegion(topLeft: topLeft, bottomRight: bottomRight)

        XCTAssertEqual(region.topLeft.latitude.totalDegrees, topLeft.latitude.totalDegrees, accuracy: eps)
        XCTAssertEqual(region.topLeft.longitude.totalDegrees, topLeft.longitude.totalDegrees, accuracy: eps)

        XCTAssertEqual(region.bottomRight.latitude.totalDegrees, bottomRight.latitude.totalDegrees, accuracy: eps)
        XCTAssertEqual(region.bottomRight.longitude.totalDegrees, bottomRight.longitude.totalDegrees, accuracy: eps)
    }
}
