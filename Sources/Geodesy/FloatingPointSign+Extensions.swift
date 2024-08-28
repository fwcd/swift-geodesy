import Foundation

extension FloatingPointSign {
    var asDouble: Double {
        switch self {
        case .plus: return 1
        case .minus: return -1
        }
    }
}
