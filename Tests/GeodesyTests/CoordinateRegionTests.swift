import XCTest
@testable import Geodesy

class CoordinateRegionTests: XCTestCase {
    func testInitializers() {
        let topLeft = Coordinates(latitude: 10, longitude: 20)
        let bottomRight = Coordinates(latitude: 30, longitude: 40)
        let region = CoordinateRegion(topLeft: topLeft, bottomRight: bottomRight)

        assertApproxEquals(region.topLeft, topLeft)
        assertApproxEquals(region.bottomRight, bottomRight)

        let region2 = CoordinateRegion(minCorner: region.minCorner, maxCorner: region.maxCorner)
        assertApproxEquals(region.minCorner, region2.minCorner)
        assertApproxEquals(region.maxCorner, region2.maxCorner)
    }
}
