import XCTest
@testable import Geodesy

let eps = 0.01

func assertApproxEquals(
    _ lhs: Degrees,
    _ rhs: Degrees,
    accuracy: Double = eps,
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTAssertEqual(lhs.totalDegrees, rhs.totalDegrees, accuracy: accuracy, file: file, line: line)
}

func assertApproxEquals(
    _ lhs: Coordinates,
    _ rhs: Coordinates,
    accuracy: Double = eps,
    file: StaticString = #file,
    line: UInt = #line
) {
    assertApproxEquals(lhs.latitude, rhs.latitude, accuracy: accuracy, file: file, line: line)
    assertApproxEquals(lhs.longitude, rhs.longitude, accuracy: accuracy, file: file, line: line)
}
