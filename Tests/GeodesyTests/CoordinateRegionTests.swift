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

    func testEdges() {
        let bottomLeft = Coordinates(latitude: 10, longitude: 20)
        let topRight = Coordinates(latitude: 30, longitude: 40)
        let region = CoordinateRegion(bottomLeft: bottomLeft, topRight: topRight)

        assertApproxEquals(region.topLeft.latitude, region.topRight.latitude)
        assertApproxEquals(region.bottomLeft.latitude, region.bottomRight.latitude)

        assertApproxEquals(region.bottomLeft.longitude, region.topLeft.longitude)
        assertApproxEquals(region.bottomRight.longitude, region.topRight.longitude)
    }

    func testResizing() {
        let bottomLeft = Coordinates(latitude: 10, longitude: 20)
        let topRight = Coordinates(latitude: 30, longitude: 50)
        var region = CoordinateRegion(bottomLeft: bottomLeft, topRight: topRight)

        region.bottomLeft.latitude.totalDegrees = 15
        assertApproxEquals(region.bottomLeft, .init(latitude: 15, longitude: 20))
        assertApproxEquals(region.bottomRight, .init(latitude: 15, longitude: 50))
        assertApproxEquals(region.topLeft, .init(latitude: 30, longitude: 20))
        assertApproxEquals(region.topRight, .init(latitude: 30, longitude: 50))
    }
}
